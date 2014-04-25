#!/bin/sh
set -e
##================================
# try command:
# exome_dir=ExomeChipPath exomeRace=ExomeRacePath/File sh AlleleFreqExome.sh
# RaceFile format: FID IID Race
#
# e.g exome_dir=readin_exome exomeRace=readin_exome/Cancer_FID_IID_race sh AlleleFreqExome.sh
##================================
echo "Exome dataset directory: "$exome_dir
echo "dataset race file full path: "$exomeRace

g1k_dir=readin_1000G

if [ -d exome ]; then
    rm -rf exome
fi
mkdir exome
mkdir exome/subset
mkdir exome/MAF


# output 1000G chrome 1 to 22 in format "chr:position SNP_ID ref alt" for 1000g_1-22_chr_pos
if [ ! -f g1k/1000g_1-22_chr_pos ]; then
    mkdir g1k
    awk '$0!~"#" {print $1":"$2"\t"$3"\t"$4"\t"$5}' $g1k_dir/G1000.vcf > g1k/1000g_1-22_chr_pos
fi

################# ExomeChip part
# extract white and black from exomechip in each cohort
files=$exome_dir/*.bed
race_list=`cut -f3 $exomeRace |grep -v U | grep -v N| sort --unique`

for f in $files
do
    dir_name=`echo $f |cut -d. -f1`
    cohort=`basename $dir_name`
#    echo $cohort
    # extract SNPs matched with 1000G
    awk '{print $1":"$4,$0}' OFS="\t" $dir_name.bim > exome/pos_bim
    cut -f1 g1k/1000g_1-22_chr_pos | perl scripts/filter.pl -f exome/pos_bim -c 1 | cut -f2- > exome/extract_SNP
    plink --noweb --bfile $dir_name --extract exome/extract_SNP --make-bed --out exome/subset/$cohort
    plink --noweb --bfile exome/subset/$cohort --within $exomeRace --freq --out exome/MAF/$cohort

    awk '{print $1":"$4}' exome/subset/$cohort.bim > exome/pos
    for race in $race_list
    do
	awk -v r=$race '$3~r {print $0}' exome/MAF/${cohort}.frq.strat > exome/MAF/${cohort}_${race}
	paste exome/pos exome/MAF/${cohort}_${race} > exome/${cohort}_${race}_pos
	sort -k1,1 exome/${cohort}_${race}_pos > exome/sorted_${cohort}_${race}_pos
    done
done

# add 1000G reference allele in exomechip
for f in $files
do
    dir_name=`echo $f |cut -d. -f1`
    cohort=`basename $dir_name`
    echo $cohort
    for race in $race_list
    do
	echo $race
	join -j 1 g1k/sorted_1000g_1-22_chr_pos exome/sorted_${cohort}_${race}_pos | awk '{print $1,$3,$4,$8,$9,$10,$12}' OFS="\t" > exome/${cohort}_${race}_ref
	# chang Minor AF to Major AF
	python scripts/MAFtoAF.py -i exome/${cohort}_${race}_ref -o exome/${cohort}_${race}_af
    done
done




# merge all cohort AF 
for race in $race_list
do
    n=0
    title="POS\tREF/ALT"
    for f in $files; do 
	n=$((n+1)); 
	title=$title"\t"$n"_A1/"$n"_A2\t"$n"_AF\t"$n"_NCHROBS"
    done
    echo -e $title > exome/exm_${race}_title

    f=`echo $files | awk '{print $1}'`
    cohort=`basename $f | cut -d. -f1`

    awk '$0!~"POS" {print $1,$2}' exome/${cohort}_${race}_af > exome/temp #pos and ref/alt

    for f in $files
    do
	dir_name=`echo $f |cut -d. -f1`
	cohort=`basename $dir_name`
#	echo $cohort

	sort -k1,1 exome/temp > exome/sorted_temp
	awk '$0!~"POS" {print $1,$3,$4,$5}' exome/${cohort}_${race}_af | sort -k1,1 > exome/sorted_af
	join -j 1 exome/sorted_temp exome/sorted_af  > exome/temp1
	cp exome/temp1 exome/temp
    done
    sed 's/ /\t/g' exome/temp > exome/exm_${race}
    sort -k1,1 -k3,3r -k4,4r exome/exm_${race}| awk '!x[$1]++ {print}' OFS="\t"> exome/temp2
    cat exome/exm_${race}_title exome/temp2 > results/final_exm_${race}
    
done
rm exome/temp
rm exome/temp1
rm exome/temp2
## final output files are results/final_exm_${race}

##========== done exome chip part ==========



############## Merge 1000G and exome chip
## current folder has file {race}_af_1kg
GRace=`find results/ -type f |grep af_1kg | cut -d_ -f1 | cut -d/ -f2`

# summary exomechip by race
set +e
for race in $GRace
do
    echo "1000G Race: "$race
    awk '$0!~"POS" {sum=0;fac=0; for (i=5;i<=NF;i+=3) {sum+=$i;fac+=$(i-1)*$i}; if (sum!=0) print $1,$2,fac,fac/sum,sum}' OFS="\t" results/final_exm_${race} > exome/exm_${race}_sum
done

# merge g1k and exm
for race in $GRace
do
    sort -k1,1 results/${race}_af_1kg > temp1
    sort -k1,1 exome/exm_${race}_sum > temp2
    join -j 1 temp1 temp2 | awk '{if ($3~"0" && $6!~"0") $3=$6; print $1,$2,$3,$4,$5,$7,$8}' | sed 's/ /\t/g' > results/final_${race}_g1k_exm
    sed -i '1iPOS\tREF/ALT\tA1/A2\tAF\tNCHROBS\texm_AF\texm_NCHROBS' results/final_${race}_g1k_exm
    rm temp1
    rm temp2
done

## Final output files are results/final_${race}_g1k_exm
############## The End ############