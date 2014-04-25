#!/bin/sh
##====================================================
# run command
# G1kRace="CEU,ASW,...,..." sh AlleleFreq1000G.sh
##====================================================

echo $G1kRace
g1k_dir=resources

mkdir g1k
mkdir g1k/MAF
mkdir results

out_dir=g1k/MAF
echo "output subset to "$out_dir

########## 1000G part
if [ ! -f g1k/1000g_1-22_chr_pos ]; then
    awk '$0!~"#" {print $1":"$2"\t"$3"\t"$4"\t"$5}' $g1k_dir/G1000.vcf > g1k/1000g_1-22_chr_pos
fi
sort -k1,1 g1k/1000g_1-22_chr_pos > g1k/sorted_1000g_1-22_chr_pos

python scripts/vcf_to_ped.py -p $G1kRace -d $out_dir

GRace=`find g1k/MAF/ -name *.tped | cut -d/ -f3 | cut -d_ -f1`

# calculate 1000G MAF by race
for race in $GRace
do
    echo $race
#    plink --noweb --tped $out_dir/${race}_G1000.tped --tfam $out_dir/${race}_G1000.tfam --make-bed --out $out_dir/$race
    plink --noweb --tped $out_dir/${race}_G1000.tped --tfam $out_dir/${race}_G1000.tfam --freq --out $out_dir/$race

    awk '{print $1":"$4}' $out_dir/${race}_G1000.tped > g1k/pos

    paste g1k/pos $out_dir/${race}.frq |sort -k1,1  > g1k/${race}_pos.frq

    join -j 1 g1k/sorted_1000g_1-22_chr_pos g1k/${race}_pos.frq| awk '{if (length($3)==1 && length($4)==1) print $1,$3,$4,$7,$8,$9,$10}' OFS="\t" > g1k/${race}_ref.frq

    # change Minor AF to Major AF 
    awk '{if ($2==$5) {print $1,$2"/"$3,$5"/"$4,$6=1-$6} else {print $1,$2"/"$3,$4"/"$5,$6}}' OFS="\t"  g1k/${race}_ref.frq > results/${race}_af_1kg
done
# Please find results in results folder
### DONE