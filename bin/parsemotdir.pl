my $start = 0;
while(<>) {
	(/BEGIN_PARSE_HTML/) && ($start = 1) && next;
	(/END_PARSE_HTML/) && ($start = 0) && next;

	#print;

	if ($start == 1) {
		if (/^\w+\|[\w\-0-9@\.]+\s*$/) {
			@pair = split(/\|/);
			print "$pair[0]: $pair[1]";
		}
	}
}
