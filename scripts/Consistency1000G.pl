use strict;
use warnings;
use Getopt::Long;

my $opt_ped  = '';
my $opt_pair = '';
my $opt_out  = '';

GetOptions(
	"f=s" => \$opt_ped,
	"p=s" => \$opt_pair,
	"o=s" => \$opt_out
);

my %GT   = ();
my %pair = ();

## read in tped file

open IN, "<$opt_ped" or die "failed to open $opt_ped \n";

print "read in tped file...\n";

while (<IN>) {

	chomp;

	my @F = split( /\s+/, $_ );

	my $id = $F[1];

	$GT{$id} = join( ",", @F[ 4 .. scalar(@F) - 1 ] );
}
close(IN);

print "done read in tped file \n";
print "start processing ...\n";

## read in snp-pair list

open OUT, ">$opt_out" or die "failed to write to $opt_out \n";

open IN, "<$opt_pair" or die "failed to open $opt_pair \n";

while (<IN>) {
	chomp;

	my ( $a, $b ) = split( /\s+/, $_ );

	next if !exists( $GT{$a} ) || !exists( $GT{$b} );

	my @g1 = split( ",", $GT{$a} );
	my @g2 = split( ",", $GT{$b} );

	my $n_comp  = 0;
	my $concord = 0;

	for ( my $i = 0 ; $i < scalar(@g1) ; $i += 2 ) {

		my $aa = $g1[$i] . $g1[ $i + 1 ];
		my $bb = $g2[$i] . $g2[ $i + 1 ];

   # if any loci contain no-called allel, do not count this loci into comparison

		my $s = $aa . $bb;

		next if $s =~ /0/;

		$n_comp++;

		$concord++ if $aa eq $bb;

	}

	if ( $n_comp != 0 ) {    #not a zeroed SNP
		print OUT join( "\t", $a, $b, $n_comp, $concord / $n_comp ), "\n";
	}
}
close(IN);
close(OUT);
print "$opt_out was successfully generated.\n";
