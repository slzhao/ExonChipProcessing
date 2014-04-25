use strict;
use warnings;
use Getopt::Long;

my $dir       = "";
my $result    = "";
my $skipLines = 8; #the first $skipLines lines will be considered as output header

GetOptions(
	"d=s" => \$dir,
	"o=s" => \$result,
);
opendir( DIR, "$dir" ) or die $!;
open RESULT, ">$result" or die $!;

my $countFile = 0;
while ( my $file = readdir(DIR) ) {
	if ( $file =~ /.csv$/ ) {
		$countFile++;
		if ( $countFile == 1 ) { #the first file, use its first $skipLines lines as output header
			print
"$countFile: Loading $file. Its first $skipLines lines will be used as result header.\n";
			open READ, "<$dir/$file" or die $!;
			while (<READ>) {
				print RESULT $_;
			}
			close(READ);
		}
		else { #Not the first file, discard its first $skipLines lines
			print
"$countFile: Loading $file. Its first $skipLines lines will be discarded.\n";
			open READ, "<$dir/$file" or die $!;
			my $lineCount = 0;
			while (<READ>) {
				$lineCount++;
				if ( $lineCount <= $skipLines ) { next; }
				print RESULT $_;
			}
			close(READ);
		}
	}
}

print "$result was successfully generated.\n";
