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

# read in ped file

open IN, "<$opt_ped" or die "failed to open $opt_ped \n";

my $k = 0;

print "read in ped file...\n";

while (<IN>) {

	chomp;

	my @F = split( /\s+/, $_ );

	my $id = $F[1];

	$GT{$id} = join( " ", @F[ 6 .. scalar(@F) - 1 ] );
}
close(IN);

print "done read in ped file \n";
print "start processing ...\n";

# read in sample-pair list

open OUT, ">$opt_out" or die "failed to write to $opt_out \n";

open IN, "<$opt_pair" or die "failed to open $opt_pair \n";

while (<IN>) {
	chomp;

	my ( $a, $b ) = split( /\s+/, $_ );

	my @g1 = split( " ", $GT{$a} );
	my @g2 = split( " ", $GT{$b} );

	my $n_comp      = 0;
	my $concord     = 0;
	my $n_het       = 0;
	my $concord_het = 0;

	for ( my $i = 0 ; $i < scalar(@g1) ; $i += 2 ) {

		my $aa = $g1[$i] . $g1[ $i + 1 ];
		my $bb = $g2[$i] . $g2[ $i + 1 ];

   # if any loci contain no-called allel, do not count this loci into comparison

		my $aabb = $aa . $bb;

		next if $aabb =~ /0/;

		$n_comp++;

		$concord++ if $aa eq $bb;

		if ( $g1[$i] ne $g1[ $i + 1 ] || $g2[$i] ne $g2[ $i + 1 ] ) {
			$n_het++;
			$concord_het++ if $aa eq $bb;
		}
	}

	# for a non-zeroed SNP
	if ( $n_comp != 0 ) {
		print OUT join( "\t", $a, $b, $n_comp, $concord / $n_comp );

		if ( $n_het != 0 ) {
			print OUT "\t", $n_het, "\t", $concord_het / $n_het;
		}
		else { print OUT "0\tNA"; }

		print OUT "\n";
	}
}
close(IN);
close(OUT);
print "$opt_out was successfully generated.\n";
