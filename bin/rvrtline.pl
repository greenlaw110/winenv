#!/bin/perl

my @lines;

while (<>) {
	push @lines, $_;
}

for ($i = @lines - 1; $i >=0; --$i) {
	print "$lines[$i]";
}
