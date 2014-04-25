dataFile<-commandArgs()[6]
raceFile<-commandArgs()[7]

resultFile<-paste0(dataFile,".jpeg")

dataConent<- read.table(dataFile, header=F,skip=11, fill = TRUE)
raceConent<- read.delim(raceFile, header=F,as.is=T)
if (NROW(raceConent) != NROW(dataConent)) {
	stop(paste0("The samples in race file (",NROW(raceConent),") is not equal to samples in PCA file (",NROW(dataConent),")\n"))
}

raceTypes<-(unique(raceConent[,3]))
col<-rainbow(length(raceTypes))
colPoints<-col[match(raceConent[,3],raceTypes)]
jpeg(resultFile,width=5, height=5,units="in",res=300)
plot(dataConent[,1],dataConent[,2],col=colPoints,las=1,xlab="PC1",ylab="PC2",cex=0.8)
legend("topright",legend=raceTypes,pch=16,col=col,bty="n")
result<-dev.off()
cat(paste(resultFile," was successfully generated.\n",sep=""))
