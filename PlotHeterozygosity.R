fileName<-commandArgs()[6]
resultFile1<-paste0(fileName,".Heterozygosity.jpg")
resultFile2<-paste0(fileName,".F.jpg")

fileContent<-read.table(fileName, header=T,as.is=T)

Heterozygosity <-(fileContent[,5]-fileContent[,3])/fileContent[,5]

jpeg(resultFile1, res=300, width=5, height=5, units="in")
hist(Heterozygosity,main="Heterozygosity Distribution",xlab="",las=1)
dev.off()
cat(paste(resultFile1," was successfully generated.\n",sep=""))

jpeg(resultFile2, res=300, width=5, height=5, units="in")
hist(fileContent[,6],main="F Distribution",xlab="",las=1)
dev.off()
cat(paste(resultFile2," was successfully generated.\n",sep=""))

