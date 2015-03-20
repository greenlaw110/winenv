#!/usr/local/bin/perl -w
##################################################
# update PR 's enclosure named file_change.lst 
##################################################
#AUthor:	Xiao Cai
#Email:		a5349c@email.mot.com
#------------------------------------------------
#
#pls input Parent PR ID and add up text file's name
#version 0.02 2004.3.2
#this version just commented the orginal text by '#'
#and paste the add up text after it 
#################################################
################################################
#main
################################################
my $objID  	=   shift ;
my $orgtxt 	=   fd_chg_lst($objID) ;
$orgtxt = substr($orgtxt,1,);    # just kick out the first useless blank symbol 
my @adduptxt 	=   load_f(shift @ARGV);
my $newstr 	=   addup($orgtxt , @adduptxt);
mkenc($objID,"file_change.lst",$newstr);

################################################
################################################
sub fd_chg_lst
{
  my($prname) = shift @_;  #parameter Record name 
  my($cmdbuf,$sqlcmdbuf);
  $sqlcmdbuf = "format  %.2048s
   	     	 select text 
	      	from enclosures 
	      	where identifier='$prname' and name='file_change.lst'";
  return sqlinterface($sqlcmdbuf) ;		
		
}
#############################################
sub sqlinterface
{
   my($sqlbuf) = @_ ; #SQL qurery statement 
   my($rtnbuf);
    
   my($cmdbuf) = sprintf ("$ENV{\"DDTSHOME\"}/bin/ddtssql -s -noheader <<_E_O_F
  		%s; 
		_E_O_F ",$sqlbuf);
  
 # open(CMD ,"$cmdbuf |") or die "can't open $cmd $!\n";
 # $rtnbuf = <CMD>;
 # close(CMD) || die "bad pipe: $?, $!";  
  $rtnbuf =` $cmdbuf `;
   return $rtnbuf;
}
#################################################
#################################################
#sub addup enclose   
#################################################
sub addup
{
  my $orgintxt = shift @_ ;        #orginal text 
  my @addtxt   =  @_ ;		   #add up text
  my @txtlst   = split /\n/ ,$orgintxt ; #split orgin text by return symbol
  foreach(@txtlst){
  		   $_ = "#".$_; #add comment symbol '#' 		 
		   chomp $_;
		  }
  my $rttxt = join "\n",(@txtlst,@addtxt) ;   		  	
  return  $rttxt ;		  
}
##################################################
#sub make enclosure 
################################################## 
sub mkenc     
{my $objPRID = shift @_;   #object PR's ID 
 my $encname = shift @_;   #name of the enclosure to be made
 my @enctext = @_;         #the content of the enclosure
 
 my ($rtbuf,$cmdbuf);
 my $today = `today`;
 chomp ($today) ;
 open(OUTFILE, ">$encname") || die "can't open $encname $? $0\n";
    foreach(@enctext){
    		      print OUTFILE "$_\n";
		      }
 close OUTFILE;

 $cmdbuf = "$ENV{\"DDTSHOME\"}/bin/batchbug -n -i $objPRID -e ./$encname  \"$encname\" Last-mod \"$today\" ";

 $rtbuf	=`$cmdbuf ` ;   
 
 unless($rtbuf){
 		unlink $encname or warn "Can't delete the $encname file\n" ;
       	       }   
 else          {
 	       print STDERR"\n batchbugs ERROR: \n$rtbuf\n";
	       }
}
#################################################
sub load_f
{ my($tmpfile) = @_;
  open(INFILE, "< $tmpfile") || die "can't open $tmpfile $? $0\n";
  my @buf = <INFILE>;
  chomp @buf ;
  close(INFILE);
   return @buf ;
}
################################################



