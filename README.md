ExonChipProcessing
==================

# Introduction #

This site contains the codes and resources for exome chip processing protocol.

The list of codes:

 Name        | Language           | Step  | Called By  | Notes  
 ------------- |:-----------:| -----:|------:|-------:
 MergeSampleSheet.pl      | Perl | 1B |User|Merging sample sheets
runZcall.py      | Python | 34A |User|Run zCall
 Gender.R      | R      |   39 |User|Checking for sex mismatch
 PCAPlot.R | R      |    43 |User|Draw scatter plot of principle Components
 PlotHWE.R | R      |    48 |User|Plot histograms of HWE test
 PlotHeterozygosity.R | R      |    50 |User|Compute heterozygosity and plot histograms of heterozygosity and inbreeding coefficient
ConsistencyDupSNP.sh	|Shell Script	|51	|User	|Prepare data for checking consistency of duplicated SNPs
ConsistencyDupSNP.pl	|Perl	|51	|ConsistencyDupSNP.sh	|Checking genotyping consistency of duplciated SNPs, called by ConsistencyDupSNP.sh
Consistency1000G.sh|	Shell Script|	52|	User	|Prepare data for checking consistency with 1000G
Consistency1000GSNP.pl|	Perl	|52	|Consistency1000G.sh	|Checking genotyping consistency with 1000G, called by Consistency1000G.sh 
exclude.pl	|Perl	|52	|Consistency1000G.sh	|Exclude bad SNPs
AlleleFreq1000G.sh	|Shell Script	|53	|User	|Compute allele frequency of 1000G
vcf_to_ped.py	|Python	|53	|AlleleFreq1000G.sh	|Convert VCF to ped
AlleleFreqExome.sh	|Shell Script	|55	|User	|Compute allale frequency of exome chip
MAFtoAF.py	|Python	|55	|AlleleFreqExome.sh	|Change MAF to allele frequency
1000GAlleleFreqPlot.R	|R	|56	|User	|Plot allele frequency scatter plot between 1000G and exome chip
BatchAlleleFreqMatrix.R	|R	|57	|User	|Plot correlation matrix between batches
filter.pl	|Perl	|52, 55	|AlleleFreqExome.sh, Consistency1000G.sh	|Filter out non-overlapping SNPs


For the resources files, you need to download them from the following links and then copy them to the resources folder under exome chip processing protocol codes folder. And you need to unzip 1000G_ExomeChipOverlapVCF.zip to get G1000.vcf.

The list of resources for 12V1_A exome chip:

 Name        | Used by Command           | Called by   | Notes 
 ------------- |:-----------:|:-----------:| -----:
[PAR_SNPs.txt](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/PAR_SNPs.txt)|	13|User in GenomeStudio|This is a list of all PAR SNPs on the exome chip, can be used for filtering them out in GenomeStudio
[Aims.txt](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/AIMs.txt)|	40|User|List of all AIMs markers on exome chip
[g1k_HumanExome-12v1_A_SNPs](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs)|	52|Consistency1000G.sh|	1000G Overlapped SNP list
[g1k_HumanExome-12v1_A_SNPs.bed](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs.bed)|	52|Consistency1000G.sh|	1000G Overlapped SNP list
[g1k_HumanExome-12v1_A_SNPs.bim](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs.bim)|	52|Consistency1000G.sh|	1000G Overlapped SNP list
[g1k_HumanExome-12v1_A_SNPs.fam](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/g1k_HumanExome-12v1_A_SNPs.fam)|	52|Consistency1000G.sh|	1000G Overlapped SNP list
[dup_snp_pair](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/dup_snp_pair)	|51|ConsistencyDupSNP.sh|	Duplicated SNP list
[1000G_ExomeChipOverlapVCF.zip (G1000.vcf)](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/1000G_ExomeChipOverlapVCF.zip)	|53, 55|AlleleFreq1000G.sh, AlleleFreqExome.sh, vcf_to_ped.py|	VCF file of 1000G data which only contains SNP overlapped with exome chip
[chr23_26.txt](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/chr23_26.txt)	|44	|plink|list of SNPs from Chr X, Y and MT
[integrated_call_samples.20101123.ped](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/integrated_call_samples.20101123.ped)	|53|vcf_to_ped.py|	Downloaded from 1000G
[integrated_call_samples.20101123.ALL.panel](https://github.com/slzhao/ExonChipProcessing/releases/download/resources.12V1_A/integrated_call_samples.20101123.ALL.panel)	|52	|Consistency1000G.sh|1000 Genome sample information downloaded from 1000G
