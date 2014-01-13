#from run-dupSNP-concord
#dup_snp_pair is under ./resources

#usage: file="" output="" sh ConsistencyDupSNP.sh

cat ./resources/dup_snp_pair|perl -lane 'print join "\n",@F' >SNP_list
plink --noweb --bfile $file --extract SNP_list --recode --transpose --out $file

perl ./scripts/ConsistencyDupSNP.pl -f ${file}.tped -p ./resources/dup_snp_pair -o $output








