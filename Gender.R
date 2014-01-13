# TODO: Add comment
# 
# Author: zhaos
###############################################################################


dataFile<-commandArgs()[6]
resultFile<-commandArgs()[7]

#gender
d1=read.table(dataFile, sep="\t", header=T)
table(d1[, 1:2])
male=subset(d1, d1$PEDSEX==1)
female=subset(d1, d1$PEDSEX==2)
jpeg(resultFile, res=300, width=10, height=5, units="in")
par(mfcol=c(1,2), pty="m")
hist(male[,6], main="Male", ylab="Freq", xlab="Chr X inbreeding estimate", breaks =100)
hist(female[,6], main="Female", ylab="Freq", xlab="Chr X inbreeding estimate", breaks=100)
result<-dev.off()
cat(paste(resultFile,"was successfully generated.\n",sep=""))
