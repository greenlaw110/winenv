use FileHandle;


#Help
my $help_string = 
"motdir.pl - Retreive LDAP information of a given coreid from motdir
Usage:
   motdir.pl <coreid>
";

##########################################################################
my $coreid;
sub process_commandline
{
   if( (! @ARGV) || (@ARGV[0] eq "-h") || (@ARGV[0] eq "-b") || (scalar(@ARGV) != 1) )
    {
	if (@ARGV[0] eq "-b" && scalar(@ARGV) == 2) {
	    $coreid = $ARGV[1];
	    exec("cmd /c start http://dir.mot.com/showUserEntry.asp?dn=motguid=$coreid,ou=people,ou=intranet,dc=motorola,dc=com");
	    exit(1);
	}
        print $help_string;

        exit(1);
    }
    $coreid = $ARGV[0];	
}
autoflush STDOUT 1;
&process_commandline;

# Create a user agent object
use LWP::UserAgent;
$ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1 ");

# Create a request
my $req = HTTP::Request->new(GET => "http://dir.mot.com/showUserEntry.asp?dn=motguid=$coreid,ou=people,ou=intranet,dc=motorola,dc=com");
$req->content_type('application/x-www-form-urlencoded');
$req->content('query=libwww-perl&mode=dist');

# Pass request to the user agent and get a response back
my $res = $ua->request($req);

# Check the outcome of the response
if ($res->is_success) {
    print $res->content;
}
else {
    print $res->status_line, "\n";
}
