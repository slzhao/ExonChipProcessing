#filename: vcf_to_ped.py
#search 1000 Genomes samples and SNP from 1000 genomes .cvf files.

import os,re,sys, getopt

def err():
    print '\n--help'
    print '\tpython vcf_to_ped.py -p <population> -d <outputfile>\nor'
    print '\tpython vcf_to_ped.py --pop <population> --dir <output directory>\n'
    print 'Example:'
    print '\tpython vcf_to_ped.py --pop GBR,CEU --dir outputdir\n'
    sys.exit()

def main(argv):
    region=''
    pop=''
    outd= ''

    try:
        opts, args = getopt.getopt(argv,"hp:d:",['pop=','dir='])
    except getopt.GetoptError:
        err()

    for opt, arg in opts:
        if opt == '-h':
            err()
        elif opt in ("-p","--pop"):
            pop = arg
        elif opt in ("-d","--dir"):
            outd = arg
    return(pop,outd)

if __name__ == "__main__":
    files=main(sys.argv[1:])
    pop_list = files[0].split(",")
    out_dir = files[1]
    print 'population: ', pop_list
    print 'output dir: ',out_dir


    db_dir = "resources" #1000G vcf dataset

    white =['CEU', 'FIN', 'GBR', 'IBS', 'TSI']
    black = ['ASW','LWK','YRI']
    hisp = ['CLM','MXL','PUR']

    wpop = []
    bpop = []
    hpop = []
    epop = []

    for race in pop_list:
        if race in white:
            wpop.append(race)
        elif race in black:
            bpop.append(race)
        elif race in hisp:
            hpop.append(race)
        else:
            epop.append(race)


    for i,pop in enumerate([wpop,bpop,hpop,epop]):
        if i==0: f='W'
        elif i==1: f='B'
        elif i==2: f="H"
        elif i==3: f='else'

        fam_lst =[]
        with open(db_dir+"/integrated_call_samples.20101123.ped","rb") as famf:
            for item in famf:
                item = item.rstrip().split()
                if item[6] in pop:
                    fam_lst.append(item[:6])

        print 'find: ',len(fam_lst),' samples in ',f
        if len(fam_lst)==0: continue

        tped_f = open(out_dir+'/'+f+'_G1000.tped','wb')
        tfam_f = open(out_dir+'/'+f+'_G1000.tfam','wb')


        with open(db_dir+'/G1000.vcf','rb') as inf:
            pos = []
            for ln in inf:
                if ln.startswith('##'): continue
                ln = ln.rstrip().split()
                if ln[0] == '#CHROM':
                    for iid in fam_lst:
                        ii = iid[1]
                        if ii in ln:
                            tfam_f.write("\t".join(iid)+'\n')
                            pos.append(ln.index(ii))
                else:
                    if len(ln[3])>1 or len(ln[4])>1: continue

                    tped_f.write(ln[0]+'\t'+ln[2]+'\t0\t'+ln[1])
                    all_1 = ln[3]
                    all_2 = ln[4]

                    for ipos in pos:
                        gt = ln[ipos].split(':')[0].split('|')
                        aa = ''
                        for (i,igt) in enumerate(gt):
                            if i == 1: 
                                aa += " "
                            if igt == '0': # reference
                                aa += all_1
                            elif igt == '1': # alternate
                                aa += all_2
                            else: 
                                aa += '0'

                        tped_f.write("\t"+aa)

                tped_f.write('\n')


        tped_f.close()
        tfam_f.close()
