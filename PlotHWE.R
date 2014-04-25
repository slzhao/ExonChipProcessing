fileName<-commandArgs()[6]
resultFile<-paste0(fileName,".HWE.jpg")

fileContent<-read.table(fileName, header=T,as.is=T)

jpeg(resultFile, res=300, width=5, height=5, units="in")
hist(fileContent[,8],main="HWE Distribution",xlab="",las=1)
dev.off()
cat(paste(resultFile," was successfully generated.\n",sep=""))
