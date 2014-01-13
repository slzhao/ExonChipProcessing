use strict;
use warnings;
use Getopt::Long;

my $opt_f='';
my $opt_col_f=1;

my %db=();

GetOptions(
	"f=s" => \$opt_f,
	"c=i" => \$opt_col_f
);

while(<>){
	chomp;
	next if /^#/;
	$db{$_}++;
}

open IN, "<$opt_f" or die "failed to open the file \n";

while(<IN>){
	chomp;	
	my @F = split(/\s+/,$_);
	if(exists($db{$F[$opt_col_f -1]})){
		print $_, "\n";
	} 
	
}
close(IN);
