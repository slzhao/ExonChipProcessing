use strict;
use warnings;
use Getopt::Long;

my $opt_file="";
my $opt_col=1;

my %db=();

GetOptions(
	"f=s" => \$opt_file,
	"c=i" => \$opt_col
);

while(<>){
	chomp;
	next if /^#/;
	$db{$_}++;
}

open IN, "<$opt_file" or die "failed to open the file \n";

while(<IN>){
        chomp;
        my @F = split(/\s+/,$_);
	print $_, "\n" unless exists($db{$F[$opt_col -1]});
		
}
close(IN);
