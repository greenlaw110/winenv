#!/usr/bin/perl

use strict;
use warnings;

our $VERSION = 0.02;

use File::Basename;
use constant PROG => basename($0);

############################################################
#
# Process options & arguments
#

use Getopt::Long qw(:config gnu_getopt);
use Pod::Usage;

my ( @regex, $ignore_case, $invert_match, $line_number,
      $with_filename, $quiet, $recursive, $files_with_matches, $count,
      $before_context, $after_context, $context );

GetOptions(
    # Regexp selection and interpretation:
    'e|regexp=s'            => \@regex,
    'f|file=s'              => sub { my ($opt, $val) = @_;
				    push @regex, regex_from_file($val) },
    'i|ignore-case'         => \$ignore_case,
    # Miscellaneous:
    'v|invert-match'        => \$invert_match, #[TODO]#
    'V|version'             => sub { print PROG . " $VERSION\n"; exit(1) },
    'h|help'                => sub { pod2usage(1) },
    # Output control:
    'n|line-number'         => \$line_number,
    'H|with-filename'       => \$with_filename,
    'h|no-filename'         => sub { $with_filename = 0 },
    'q|quiet|silent'        => \$quiet,
    'L|files-without-match' => sub { $files_with_matches = 0 }, #[TODO]#
    'l|files-with-matches'  => \$files_with_matches, #[TODO]#
    'c|count'               => \$count,
    # Context control:
    'A|after-context=i'     => \$after_context,
    'B|before-context=i'    => \$before_context,
    'C|context:i'           => \$context,
) or pod2usage(2);


####################
#
# Regex is first argument unless -e or -f
#
push @regex, shift( @ARGV ) unless @regex;


####################
#
# Handle globbing

use File::Glob ();

sub do_globbing {
     my @files;
     foreach my $arg ( @_ ) {
	push @files, File::Glob::bsd_glob( $arg, File::Glob::GLOB_CSH );
     }
     return @files;
}

my @files = map { do_globbing($_) } @ARGV;

####################
#
# Option defaults

# print filename if processing more than 1 file unless explicitly asked not to
$with_filename = 1
     if @files > 1 && !(defined( $with_filename ) && ( $with_filename == 
0 ));


$ignore_case = 0 unless defined( $ignore_case );

# Default for context is 2 if not given
$context = 2 if ( defined( $context ) && $context == 0 );

# Make sure $context is on if either of before or after is defined.
if (defined( $before_context) || defined( $after_context )) {
     $context ||= 2;
} else {
     $context ||= 0;
}

# Use $context as default.
$before_context ||= $context unless defined( $before_context );
$after_context  ||= $context unless defined( $after_context );

# Options 'files_with_matches' & 'count' override other output
$quiet = 1 if ( defined( $files_with_matches ) && $files_with_matches ) ||
	      ( defined( $count ) && $count );

sub regex_from_file {
     my $file = shift;
     my @regex;
     open( FH, $file ) or die "Can't open '$file': $!\n";
     while (defined( my $line = <FH> )) {
	chomp( $line );
	push @regex, $line;
     }
     close( FH );
     return @regex;
}


# Is it worth optimizing for the case where the same file
# is grepped more than once? (i.e. grep pattern file1 file2 file1)


############################################################
#
# Main loop

# Allow for flexible printing formats
sub pretty_print {
     my( $filename, $linenumber, $string, $match ) = @_;

     return if $quiet;

     my $sep = $match ? ':' : '-';

     if ( defined( $with_filename ) && $with_filename ) {
	$filename .= $sep;
     } else {
	$filename = '';
     }

     if ( defined( $line_number ) && $line_number ) {
	$linenumber .= $sep;
     } else {
	$linenumber = '';
     }

     printf "%s%s%s\n", $filename, $linenumber, $string;
}


my( $total_matches );

foreach my $file ( @files ) {
     unless (open( FH, $file )) {
	warn PROG . ": $file: $!\n";
	next;
     }

     my (@before_context_buffer, $after_context_remaining);
     while (defined( my $line = <FH> )) {
	chomp( $line );

	# store lines for 'before' context
	push @before_context_buffer, [ $file, $., $line, 0 ]
	    unless $after_context_remaining;
	shift @before_context_buffer
	    if ($#before_context_buffer > $before_context);

	# print 'after' context if needed
	if ( $after_context_remaining ) {
	    pretty_print( $file, $., "$line", 0 );
	    --$after_context_remaining;
	}

	foreach my $regex ( @regex ) {
	    if (( $ignore_case && $line =~ m/$regex/i ) ||
		( $line =~ m/$regex/ ) ||
		( $invert_match )) {
		++$total_matches;

		# the order of the following tasks is important
		$after_context_remaining = $after_context;

		print "---\n"
		    if ( $after_context_remaining == 2 ) &&
		       ( @before_context_buffer ) && ( $total_matches - 1 );

		$before_context_buffer[-1][3] = 1 if @before_context_buffer;
		foreach my $buf ( @before_context_buffer ) {
		    pretty_print( @$buf );
		}
		@before_context_buffer = ();
	    }
	}

     }
     close( FH );
}

print "$total_matches\n" if $count;


__END__

=head1 NAME

pgrep - Perl implementation of GREP

=head1 SYNOPSIS

  pgrep [OPTION]... PATTERN [FILE] ...

  Regexp selection and interpretation:
    -e, --regexp=PATTERN      Use PATTERN as a regular expression.
                              (This and the next option are additive.)
    -f, --file=FILE           File with one or more regexp separated by 
newlines
    -i, --ignore-case         Ignore case distinctions.

  Miscellaneous:
    -v, --invert-match        Select non-matching lines.
    -V, --version             Print version information and exit.
    -h, --help                Display this help and exit.

  Output control:
    -n, --line-number         Print line number with output lines.
    -H, --with-filename       Print the filename for each match.
    -h, --no-filename         Suppress the prefixing of filename on output.
    -q, --quiet, --silent     Suppress all normal output.
    -L, --files-without-match Only print FILE names containing no match.
    -l, --files-with-matches  Only print FILE names containing matches.
    -c, --count               Only print a count of matching lines per FILE.

  Context control:
    -A, --after-context=NUM   Print NUM lines of leading context.
    -B, --before-context=NUM  Print NUM lines of trailing context.
    -C, --context[=NUM]       Print NUM (default 2) lines of output context.
                              unless overriden by -A or -B

=head1 AUTHOR

Randy W. Sims <RandyS@ThePierianSpring.org>

=head1 SEE ALSO

  GNU grep <http://www.gnu.org/directory/grep.html>

=head1 COPYRIGHT

This software is distributed under the same terms as perl.

