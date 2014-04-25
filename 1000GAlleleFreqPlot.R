dataFile<-commandArgs()[6]
resultFile<-commandArgs()[7]

w1k1<- read.table(dataFile,header=T)
jpeg(resultFile,res=300, width=5, height=5, units="in")
a2<-cor(w1k1$exm_AF, w1k1$AF,method="spearman")
plot(w1k1$exm_AF, w1k1$AF,xlab="Exome Chip",ylab="1000G",main="1000G vs Exome Chip in European Ancestry",cex=.4)
g<-lm(w1k1$exm_AF~ w1k1$AF)#)
abline(g,lty=5,col=2,lwd=2)
legend("topleft",paste("correlation = ",round(a2,2)),cex=1,bty='n')
result<-dev.off()
cat(paste(resultFile," was successfully generated.\n",sep=""))
