use Time::localtime;

# to make STDOUT flush immediately, simply set the variable
# this can be useful if you are writing to STDOUT in a loop
# many times the buffering will cause unexpected output results
$| = 1;

my $is_normal = 1;
my $MAX_ERR = 4;
my $err = 0;
while (<>)
{
	(/^\s+$/) && next;
	$now = ctime();
	print "$now \> $_";
	if (not $is_normal) {
		if (/Reply/) {
			$is_normal = 1; $err = 0;
			print "$now \> connection restored.\n";
		}
	} else {
		if (/Request/) {
			if ($err < $MAX_ERR) {
				$err++; next;
			} else {
				$is_normal = 0;
				print "$now \> connection broken, start to reset NIC.\n";
				system("cmd", "/c", "resetnic");
			}
		} else {
			if (/Reply/) {
				$err = 0;
			}
		}
	}
}