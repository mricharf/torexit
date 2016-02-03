#!perl.exe
# torexit.pl - takes published TOR exit node list and 
# parses for IP address

use strict;
use warnings;
use LWP::Simple;

my $class;
my $entry;
my $exitlist;
my $exitnodecount=0;

my $furl = "https://check.torproject.org/exit-addresses";
my $outfile = "exit-addresses.csv";
open CSVOUT, ">", $outfile or die("Cannot create output CSV.\n");

# retrieve latest list from TOR Project site
$exitlist =  get($furl);

# split the list per line
my @exitlist_ary = split("\n", $exitlist); 

foreach my $line (@exitlist_ary) {
	($class, $entry) = split(" ", $line);
	if ($entry =~ m/(\d{1,3}\.){3}\d{1,3}/g) { 
		# found one of the exit node IPs
		print CSVOUT "$entry\n";
		$exitnodecount++;		
	}
}
print "Exported $exitnodecount TOR exit node IP addresses to $outfile\n";

