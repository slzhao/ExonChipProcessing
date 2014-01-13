## extract IDs for common-to-g1k-and-data samples
cut -f1 ./resources/integrated_call_samples.20101123.ALL.panel > ./resources/allG1000Sample.txt
cat ${file}.fam |grep -f ./resources/allG1000Sample.txt |perl -lane 'print join ("\t",@F[0,1])' >data_ID_to_extract
cat data_ID_to_extract|perl -lane '$F[1]=~/_SID([HN][AG][\d]+)_/; print $1, "\t",$1'|sort -u > g1k_ID_to_extract

## extract the common-to-g1k-and-data snps
cut -f2 ./resources/g1k_HumanExome-12v1_A_SNPs|perl ./scripts/filter.pl -f ${file}.bim -c 2|cut -f2 >snps_g1k_overlap_HumanExome-12v1_A

## reshape to get a common-snps by common-samples matrix for each
plink --noweb --bfile $file --keep data_ID_to_extract --extract snps_g1k_overlap_HumanExome-12v1_A --make-bed --out data_overlap_w_g1k
plink --noweb --bfile ./resources/g1k_HumanExome-12v1_A_SNPs --keep g1k_ID_to_extract --extract snps_g1k_overlap_HumanExome-12v1_A --make-bed --out g1k_overlap_w_data

## merge data and g1k
plink --noweb --bfile data_overlap_w_g1k --bmerge g1k_overlap_w_data.bed g1k_overlap_w_data.bim g1k_overlap_w_data.fam --recode --out merge_data_g1k

## exclude the missnp resulting from the merge step
plink --noweb --bfile data_overlap_w_g1k --exclude merge_data_g1k.missnp --make-bed --out data_overlap_w_g1k_exclude_missnp
plink --noweb --bfile g1k_overlap_w_data --exclude merge_data_g1k.missnp --make-bed --out g1k_overlap_w_data_exclude_missnp
cat merge_data_g1k.missnp |perl ./scripts/exclude.pl -f snps_g1k_overlap_HumanExome-12v1_A -c 1 >snps_to_exclude

## merge the new files
plink --noweb --bfile data_overlap_w_g1k_exclude_missnp --bmerge g1k_overlap_w_data_exclude_missnp.bed g1k_overlap_w_data_exclude_missnp.bim g1k_overlap_w_data_exclude_missnp.fam --recode --out merge_g1k_data_exclude_missnp

## extract data 
cut -f2 data_ID_to_extract|perl -lane '$a=$_; $_=~/_SID([HN][AG]\d+)_/; print $a,"\t",$1' > data_g1k_ID_pair

## calculate the concordance between data and g1k 
perl ./scripts/Consistency1000G.pl -f merge_g1k_data_exclude_missnp.ped -p data_g1k_ID_pair -o $output
