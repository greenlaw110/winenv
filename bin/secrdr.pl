#!/usr/bin/perl

# Assumption: only one argument to find the section header
# Usage: cat <your-text> | secrdr.pl <your-section-header-key-word>

my $key = $ARGV[0];
$key = '' if not defined($key);

my $print_start = 0;
while (<STDIN>) {
	chop;
	if ($print_start) {
		(/^\-+$/) && ($print_start = 0);
		print "$_\n";
	} else {
		($print_start = 1 && print "$_\n") if (/^\-+.*$key/);
	}
}