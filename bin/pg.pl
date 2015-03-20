#!/usr/bin/perl
use warnings;
use strict;
use File::Find;
my $dir = shift || '.';
$/ = \2_048;  # set buffer size to 2,048 bytes, YMMV
find( sub {
    local @ARGV = $File::Find::name;
    my $last = '';
    while ( <> ) {
        $_ = $last . $_;
        if ( /pattern1/ or /pattern2/ or /pattern3/ ) {
            print "$ARGV\n";
            close ARGV;
            return;
            }
        $last = $_;
        }
    }, $dir );
__END__

