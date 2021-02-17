#****************************************************
# Program:	yeastGenesTopTen.pl
# Author:	Theodore Gouskos
# Abstract:
#****************************************************
#!/usr/bin/perl

use strict;
use warnings;

open (F1, "<Yeastgeneinfo.txt") or die "Yeastgeneinfo.txt file not found. $!";
open (F, "<YeastProteinORFs.dat") or die "YeastProteinORFs.dat file not found. $!";
my %ORFtoGeneName;	# THIS HASH HAS ORF NAMES AS ITS KEYS AND GENE NAMES AS ITS VALUES

while(<F1>){		# Read the Yeastgeneinfo.txt file and build the hash
	chomp;
	my @cols = split (/\t/, $_);		#split the line by tabs and save values into array @cols
	if ($cols[0] eq "Species_ID"){		#skip the header row
		next;
	}
	$ORFtoGeneName{$cols[3]} = $cols[2];
}


my %counts;		# a hash to keep track of how many times each ORF appears
my $ORF;		# variable to hold each ORF read in

while (defined($ORF = <F>))	# for every ORF in the input
{
	chomp($ORF);
	$counts{$ORF}++;
}

print "\nThe top 10 ORFs that appear on the file:\n";
my $n = 0;		# a counter to keep track of how many have printed
foreach my $key (sort {$counts{$b} <=> $counts{$a} } keys %counts) # sort values in descending order
{
	print "ORF: $key (Gene name: $ORFtoGeneName{$key}) appears $counts{$key} times.\n";
	$n++;
	last if ($n == 10);	# end loop after 10 iterations
}

close F1;
print "\nThe End\n\n";
