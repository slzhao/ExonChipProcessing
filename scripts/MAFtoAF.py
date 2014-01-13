import sys,getopt,os

def err():
    print '\n--help'
    print '\tpython MAFtoAF.py -i <inputfile> -o <outputfile>\n'
    sys.exit()

def main(argv):
    inf=''
    outf=''

    try:
        opts,args = getopt.getopt(argv,"hi:o:",['inf=','outf='])
    except getopt.GetoptError:
        err()

    for opt, arg in opts:
        if opt == '-h':
            err()
        elif opt in ("-i","--inf"):
            inf = arg
        elif opt in ("-o","--outf"):
            outf = arg
    return(inf,outf)

def gt_eq(a,b):
    gt = [['A','T'],['C','G']]
    rst = False
    for i in gt:
        if a in i and b in i:
            rst = True
            break
    return rst

if __name__ == "__main__":
    files=main(sys.argv[1:])
    inf = open(files[0],'rb')
    outf= open(files[1],'wb')

    outf.write('POS\tREF/ALT\tA1/A2\tAF\tNCHROBS\n') # title
    wlst = inf.readlines()
    for i in range(len(wlst)):
        ln = wlst[i].rstrip().split()

        if (gt_eq(ln[1],ln[3]) or ln[3]=='0') and gt_eq(ln[2],ln[4]): #G/T = C/T or G/T = 0/A
            af = float(ln[5])
        elif gt_eq(ln[1],ln[4]) and (ln[3] == '0' or gt_eq(ln[2],ln[3])): # C/T T/C switch exome A1/A2
            tmp = ln[3]
            ln[3] = ln[4]
            ln[4] = tmp
            af = 1-float(ln[5])
        elif ln[3] == '0' and ln[4] == '0': # exome got zero call
            pass
        else: # if different calls found between 1000G and ExomeChip, zero exome chip
            for ii in range(3,len(ln)):ln[ii] = '0'

        outf.write(ln[0]+"\t"+ln[1]+'/'+ln[2]+'\t'+ln[3]+'/'+ln[4]+'\t'+str(af)+'\t'+ln[-1]+'\n')

    inf.close()
    outf.close()

