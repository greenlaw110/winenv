#!/usr/local/bin/perl -w
######################################################
#Genrate XML report of all new IRs and related DRs
######################################################
#Author:	Olina Li
#Email:		a5458c@motorola.com
######################################################
#
# Description:
#	1.Select new IRs in specified project 
#	2,Generate report of all IRs' information
#	3.Generate plain text file including all DRs
#	4.Generate DRs' change list
# SYNOPSIS:		
#		irreporttool.pl -m	
#	or	orirreporttool.pl -n
# Argument:
#	-m:operate MORPHEUS project
#	-n:operate NEO project
# OUTPUT:
#	 Three files:
#		irreport.xml;drlist.txt;changelist.lst
# History
# 	D01.00	Olina Li	2004/9/15
#	D02.00  Olina Li	2004/9/17
# 		1.Add some information in changelist.lst
#		2.Order tag attribution in XML report
#		3.Argument from "m" to "-m"
######################################################


#################### main ############################

##verify arg and get project name
if ($#ARGV<0)
{
print<<"EOF";
Error!
Must input one argument and the argument should be "-m" or "-n"!
-m: Project MORPHEUS.Integration.ZMYmy
-n: Project NEO.Integration.ZMYmy
EOF
exit 0;
}
my $project=shift;
if ($project eq "-m")
{
$project='MORPHEUS.Integration.ZMYmy';
}
elsif ($project eq "-n")
{
$project='NEO.Integration.ZMYmy';
}
else
{
print<<"EOF";
Error!
Must input one argument and the argument should be "-m" or "-n"!
-m: Project MORPHEUS.Integration.ZMYmy
-n: Project NEO.Integration.ZMYmy
EOF
exit 0;
}

my $build=shift;
if ($build eq "")
{
$build=1;
}


##get new IR
my @newirtxtbuf=findnewIR($project);
unless (@newirtxtbuf)
{
	print"Sorry!\nNo new IR now!\n";
	exit 0;
}

##organize a pretty data structure 
my @irarray=reconstructbuf(@newirtxtbuf);

##generate XML Report
generatexmlrpt(@irarray);

##end tool
print "Thanks!\nThree files are generated:irreport.xml,drlist.txt,changelist.lst!\n";
#################### end of main ##################### 


############ sub: get new IR from ddts ###############
sub findnewIR
{
        my $project=shift;
        my($sqlquery) = " $ENV{\"DDTSHOME\"}/bin/ddtssql -s -noheader <<_E_O_F
                        format %-10s %-25s %-1s %-72s
                        select identifier,submitter_name,priority,headline
                        from defects
                        where class='Integration'
                        and project='$project'
                        and feature like 'LTD App%'
                        and release='LTD Build $build'
                        and status='N'
                        ;
                        _E_O_F ";
        return `$sqlquery`;
}

######### sub:reconstruct every IR data struct #########
sub reconstructbuf
{
        open(TEXTFILE,">drlist.txt");
	open (CHANGELSTFILE,">changelist.lst");
	my (@irarray,%rtircell,@drarray,%ircell);
	foreach $item(@_)
        {
                my $tmpirid=substr($item,0,10);
		my $tmpsubmitter=substr($item,11,25);
		my $tmppriority=substr($item,37,1);
		my $tmpheadline=substr($item,-73,72);
		$tmpsubmitter=~s/\s+$//;
		$tmpheadline=~s/\s+$//;		
		$ircell{"IRID"}=$tmpirid;
                $ircell{"Submitter"}=$tmpsubmitter;
                $ircell{"Priority"}=$tmppriority;
                $ircell{"Headline"}=$tmpheadline;

                my $irid=$tmpirid;
                @drarray=getdrarray($irid);
                %rtircell=(%ircell,"DR"=>[@drarray]);
                
                push(@irarray,{%rtircell});
        }
	close(TEXTFILE);
	close(CHANGELSTFILE);
        return @irarray;
}

#################### sub:get DR Array ####################
sub getdrarray
{
        my ($irid)=@_;
	my $encconfbuf=getencconf($irid);  #get enclosures configuration text
        my(@drlst)=pickdr($encconfbuf);
	unless (@drlst)
	{
		print"Warning!\nNo DR in $irid!\n";
		return;
	}
        my @drinfoarray=getdrinfo(@drlst);
        return @drinfoarray;
}

######### sub:get enclosures of configuration text #######
sub getencconf
{
	my($irname)=@_;	
	
	my($sqlquery) = " $ENV{\"DDTSHOME\"}/bin/ddtssql -s -noheader <<_E_O_F
 	 		format %.20480s 
			select text
			from enclosures 
			where identifier='$irname' and name='Configuration' 
			;
			_E_O_F ";
	
	return`$sqlquery`;
}

## sub:pick DR from donfiguration and generate drlist.txt ##
sub pickdr
{
        
        my @encconfbuf=split(/\n+/,$_[0]);
	my @drlstbuf;
        while($line=shift(@encconfbuf))
        {
                if($line=~s/%SCM% Bugs_Fixed/ ### /)
                {
                        while($line =~s/([0-9a-zA-Z]+)/ ### /)
                        {
                                push(@drlstbuf , $1);
                                print TEXTFILE "$1\n";

                        }
                        $line=shift(@encconfbuf);
                        while(!(($line =~ /^-+/)&&($line =~ /^.*-+/)))
                        {
                                while($line =~ s/([0-9a-zA-Z]+)/ ### /)
                                {
                                        push(@drlstbuf , $1);
                                        print TEXTFILE "$1\n";
                                }
                                $line=shift(@encconfbuf);
                        }
                last;
                }
        }
       
        return @drlstbuf;
}

################## sub:get DR infomation######################
sub getdrinfo
{
        my (@drbuf);
	foreach $dritem(@_)
        {
		my($sqlquery) = " $ENV{\"DDTSHOME\"}/bin/ddtssql -s -noheader <<_E_O_F
	                        format %-25s %-1s %-68s %-1s %-1s %-72s %s
	                        select D.submitter_name,D.status,D.project,
	                                D.severity,D.enhancement,D.headline,E.text
	                        from defects D,enclosures E
 	                        where D.identifier='$dritem'
 	                        and D.identifier=E.identifier
  	                        and E.name='file_change.lst'
 	                       ;
 	                       _E_O_F ";
 	        my $drinfobuf=`$sqlquery`;
		
		my $tmpsubmitter=substr($drinfobuf,0,25);		
		my $tmpstatus=substr($drinfobuf,26,1);
		my $tmpproject=substr($drinfobuf,28,68);		
		my $tmpseverity=substr($drinfobuf,97,1);
		my $tmpenhancement=substr($drinfobuf,99,1);
		my $tmpheadline=substr($drinfobuf,101,72);
		my $tmpchanglst=substr($drinfobuf,174);
		$tmpsubmitter=~s/\s+$//;
		$tmpproject=~s/\s+$//;
		$tmpheadline=~s/\s+$//;
		$tmpchanglst=~s/\s+$//;		
		
		my %drinfobuf;		
 	        $drinfobuf{"submitter"}=$tmpsubmitter;
       	 	$drinfobuf{"status"}=$tmpstatus;
      	  	$drinfobuf{"project"}=$tmpproject;
      	  	$drinfobuf{"severity"}=$tmpseverity;
        	$drinfobuf{"enhancement"}=$tmpenhancement;
        	$drinfobuf{"headline"}=$tmpheadline;
        	$drinfobuf{"changelist"}=$tmpchanglst;	
        	
		unless( $tmpchanglst ) 
		{$tmpchanglst = "\nWARN:DO NOT FIND $_ 's CHANGLIST\n";}	
		generatechglst($dritem,$tmpheadline,$tmpsubmitter,
				$tmpseverity,$tmpstatus,$tmpchanglst);	
	
		my %drinfor=("ID"=>"$dritem",%drinfobuf);
        	push(@drbuf,{%drinfor});        	
        }
	return @drbuf;
}

################# sub:generate XML report ######################
sub generatexmlrpt
{	
	use XML::Generator;
	use Tie::IxHash;
	my ($xml, $foutput,%irhash,$drarrayref,@irxmlarray,@irxml,
	    @drarray,@drxml,%drhash,@drxmlarray);
	$xml = XML::Generator->new(':pretty');
	@irxml=();
	foreach (@_)
	{
		%irhash=%$_;
		$drarrayref=$irhash{"DR"};
		#delete $irhash{"DR"};
		tie my %tieirhash,'Tie::IxHash';
		%tieirhash=(ID=>$irhash{"IRID"},
			    Priority=>$irhash{"Priority"},						   
			    Headline=>$irhash{"Headline"},
			    Submitter=>$irhash{"Submitter"});
		@drarray=@$drarrayref;
		@drxml=(); 
		foreach(@drarray)
		{
			%drhash=%$_;
			$changelst=$drhash{"changelist"};
			$changelst ="\n".$changelst;
			$changelst .="\n";
			#delete $drhash{"changelist"};
			tie my %tiedrhash,'Tie::IxHash';
			%tiedrhash=(ID=>$drhash{"ID"},
				    Status=>$drhash{"status"},						   
				    Severity=>$drhash{"severity"},
				    Headline=>$drhash{"headline"},
				    Submitter=>$drhash{"submitter"},
				    Enhancement=>$drhash{"enhancement"},
				    Project=>$drhash{"project"});		
			
			@drxmlarray=($xml->DR(\%tiedrhash,
     			 	   	      $xml->ChangeList($changelst)
     			 	   	     )
				    );
			@drxml=(@drxml,@drxmlarray);
		 }		
		@irxmlarray=($xml->IR(\%tieirhash,@drxml));     		
     		@irxml=(@irxml,@irxmlarray);
	}	 	   	
        	
	$foutput=$xml->Integration_Report( @irxml);
  	open(XMLFILE,">irreport.xml");
	print XMLFILE $foutput;
	close(XMLFILE); 
}

################ sub:generate changelist.lst file##############
sub generatechglst
{
	my($prname ,$headline,$submitter,$severity,$status,$text) = @_ ;
  	my($rtbuf) = "\n"; 
	$rtbuf .= "#"x75 ;
  	$rtbuf .= "\n#  PR NAME   :  $prname\n";
	$rtbuf .= "#"x75 ;
	$rtbuf .= "\n#  Headline  :  $headline\n";
	$rtbuf .= "#  Submitter :  $submitter\n";
	$rtbuf .= "#  Severity  :  $severity\n";
	$rtbuf .= "#  Status    :  $status\n";
  	$rtbuf .= "#"x75;
  	$rtbuf .= "\n\n$text \n" ;
	print CHANGELSTFILE $rtbuf ;
}

############################# End ##############################


















































































































































































































