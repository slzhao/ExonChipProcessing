echo $G1kRace
g1k_dir=readin_1000G

mkdir g1k
mkdir g1k/MAF

########## 1000G part
python scripts/vcf_to_ped.py -p $G1kRace -d g1k/


# calculate 1000G MAF by race
for race in W B H
do
    plink --noweb --tped g1k/${race}_G1000.tped --tfam g1k/${race}_G1000.tfam --freq --out g1k/MAF/$race
    awk '{print $1":"$4}' ${race}_G1000.tped >> g1k/pos

    paste g1k/pos g1k/MAF/${race}.frq > g1k/${race}_pos.frq
    join -j 1 <(sort -k1,1 g1k/1000g_1-22_chr_pos) <(sort -k1,1 g1k/${race}_pos.frq)| awk '{if (length($3)==1 && length($4)==1) print $1,$3,$4,$7,$8,$9,$10}' OFS="\t" > g1k/${race}_ref.frq
    # change Minor AF to Major AF 
    awk '{if ($2==$5) {print $1,$2"/"$3,$5"/"$4,$6=1-$6} else {print $1,$2"/"$3,$4"/"$5,$6}}' OFS="\t"  g1k/${race}_ref.frq > ${race}_af_1kg
done
### DONE