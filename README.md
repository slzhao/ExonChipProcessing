ExonChipProcessing
==================

# Introduction #

This site contains the codes and resources for exome chip processing protocol.

The list of codes:

 Name        | Language           | Step  | Called By  | Notes  
 ------------- |:-----------:| -----:|------:|-------:
 MergeSampleSheet.pl      | Perl | 1 |User|Merging sample sheets
 Gender.R      | R      |   12 |User|Checking for sex mismatch
 PCAPlot.R | R      |    13 |User|Draw scatter plot of principle Components
Consistency1000G.sh|	Shell Script|	17|	User	|Prepare data for checking consistency with 1000G
Consistency1000GSNP.pl|	Perl	|17	|Consistency1000G.sh	|Checking genotyping consistency with 1000G, called by Consistency1000G.sh 
ConsistencyDupSNP.sh	|Shell Script	|17	|User	|Prepare data for checking consistency of duplicated SNPs
ConsistencyDupSNP.pl	|Perl	|17	|ConsistencyDupSNP.sh	|Checking genotyping consistency of duplciated SNPs, called by ConsistencyDupSNP.sh
exclude.pl	|Perl	|17	|Consistency1000G.sh	|Exclude bad SNPs
AlleleFreq1000G.sh	|Shell Script	|18	|User	|Compute allele frequency of 1000G
AlleleFreqExome.sh	|Shell Script	|18,19	|User	|Compute allale frequency of exome chip
filter.pl	|Perl	|18,19	|AlleleFreqExome.sh, Consistency1000G.sh	|Filter out non-overlapping SNPs
MAFtoAF.py	|Python	|18,19	|AlleleFreqExome.sh	|Change MAF to allele frequency
vcf_to_ped.py	|Python	|18,19	|AlleleFreq1000G.sh	|Convert VCF to ped
1000GAlleleFreqPlot.R	|R	|18	|User	|Plot allele frequency scatter plot between 1000G and exome chip
BatchAlleleFreqMatrix.R	|R	|19	|User	|Plot correlation matrix between batches


For the resources files, you need to download them from the following links and then copy them to the resources folder under exome chip processing protocol codes folder.

The list of resources for 12V1_A exome chip:

 Name        | Used by Command           | Notes 
 ------------- |:-----------:| -----:
[g1k_HumanExome-12v1_A_SNPs](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs)|	13|	1000G Overlapped SNP list
[g1k_HumanExome-12v1_A_SNPs.bed](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs.bed)|	13|	1000G Overlapped SNP list
[g1k_HumanExome-12v1_A_SNPs.bim](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs.bim)|	13|	1000G Overlapped SNP list
[g1k_HumanExome-12v1_A_SNPs.fam](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs.fam)|	13|	1000G Overlapped SNP list
[dup_snp_pair](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/dup_snp_pair)	|14|	Duplicated SNP list
[1000G_ExomeChipOverlapVCF.zip](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/1000G_ExomeChipOverlapVCF.zip)	|15|	VCF file of 1000G data which only contains SNP overlapped with exome chip
[chr23_26.txt](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/chr23_26.txt)	|8, 11	|list of SNPs from Chr X, Y and MT
[integrated_call_samples.20101123.ped](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/integrated_call_samples.20101123.ped)	|15|	Downloaded from 1000G
[integrated_call_samples.20101123.ALL.panel](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/integrated_call_samples.20101123.ALL.panel)	|17	|1000 Genome sample information downloaded from 1000G
