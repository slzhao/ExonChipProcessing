ExonChipProcessing
==================

# Introduction #

This site contains the codes and resources for exome chip processing protocol.

The list of codes:

 Name        | Language           | Step  | Called By  | Notes  
 ------------- |:-----------:| -----:|------:|-------:
 MergeSampleSheet.pl      | Perl | 1 |User|Merging sample sheets
runZcall.py      | Python | 22 |User|Run zCall
 Gender.R      | R      |   27 |User|Checking for sex mismatch
 PCAPlot.R | R      |    29 |User|Draw scatter plot of principle Components
 PlotHWE.R | R      |    33 |User|Plot histograms of HWE test
 PlotHeterozygosity.R | R      |    36 |User|Compute heterozygosity and plot histograms of heterozygosity and inbreeding coefficient
ConsistencyDupSNP.sh	|Shell Script	|37	|User	|Prepare data for checking consistency of duplicated SNPs
ConsistencyDupSNP.pl	|Perl	|37	|ConsistencyDupSNP.sh	|Checking genotyping consistency of duplciated SNPs, called by ConsistencyDupSNP.sh
Consistency1000G.sh|	Shell Script|	38|	User	|Prepare data for checking consistency with 1000G
Consistency1000GSNP.pl|	Perl	|38	|Consistency1000G.sh	|Checking genotyping consistency with 1000G, called by Consistency1000G.sh 
exclude.pl	|Perl	|38	|Consistency1000G.sh	|Exclude bad SNPs
AlleleFreq1000G.sh	|Shell Script	|39	|User	|Compute allele frequency of 1000G
vcf_to_ped.py	|Python	|39	|AlleleFreq1000G.sh	|Convert VCF to ped
AlleleFreqExome.sh	|Shell Script	|41	|User	|Compute allale frequency of exome chip
MAFtoAF.py	|Python	|41	|AlleleFreqExome.sh	|Change MAF to allele frequency
1000GAlleleFreqPlot.R	|R	|42	|User	|Plot allele frequency scatter plot between 1000G and exome chip
BatchAlleleFreqMatrix.R	|R	|43	|User	|Plot correlation matrix between batches
filter.pl	|Perl	|38, 41	|AlleleFreqExome.sh, Consistency1000G.sh	|Filter out non-overlapping SNPs


For the resources files, you need to download them from the following links and then copy them to the resources folder under exome chip processing protocol codes folder. And you need to unzip 1000G_ExomeChipOverlapVCF.zip to get G1000.vcf.

The list of resources for 12V1_A exome chip:

 Name        | Used by Command           | Called by   | Notes 
 ------------- |:-----------:|:-----------:| -----:
[g1k_HumanExome-12v1_A_SNPs](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs)|	38|Consistency1000G.sh|	1000G Overlapped SNP list
[g1k_HumanExome-12v1_A_SNPs.bed](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs.bed)|	38|Consistency1000G.sh|	1000G Overlapped SNP list
[g1k_HumanExome-12v1_A_SNPs.bim](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs.bim)|	38|Consistency1000G.sh|	1000G Overlapped SNP list
[g1k_HumanExome-12v1_A_SNPs.fam](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs.fam)|	38|Consistency1000G.sh|	1000G Overlapped SNP list
[dup_snp_pair](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/dup_snp_pair)	|37|ConsistencyDupSNP.sh|	Duplicated SNP list
[g1k_overlap_w_data](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_overlap_w_data)	|38|Consistency1000G.sh|	PLINK file of 1000G data which only contains SNP overlapped with exome chip
[1000G_ExomeChipOverlapVCF.zip](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/1000G_ExomeChipOverlapVCF.zip)	|39, 41|AlleleFreq1000G.sh, AlleleFreqExome.sh, vcf_to_ped.py|	VCF file of 1000G data which only contains SNP overlapped with exome chip
[chr23_26.txt](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/chr23_26.txt)	|30, 34	|plink|list of SNPs from Chr X, Y and MT
[integrated_call_samples.20101123.ped](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/integrated_call_samples.20101123.ped)	|39|vcf_to_ped.py|	Downloaded from 1000G
[integrated_call_samples.20101123.ALL.panel](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/integrated_call_samples.20101123.ALL.panel)	|38	|Consistency1000G.sh|1000 Genome sample information downloaded from 1000G
