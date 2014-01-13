# TODO: Add comment
# 
# Author: zhaos
###############################################################################

dataFile<-commandArgs()[6]
resultFile<-commandArgs()[7]

aa = read.table(dataFile, header=T,sep="\t")
jpeg(resultFile,width=5, height=5,units="in",res=300)
plot(aa$PCA1, aa$PCA2, type='n', main="", xlab="PCA1", ylab="PCA2",lwd=4)

points (aa$C1[aa$ETHNIC=="chip"], aa$C2[aa$ETHNIC1=="chip"],lwd=2, col=6)
points (aa$C1[aa$ETHNIC=="AMR"], aa$C2[aa$ETHNIC=="AMR"],lwd=2, col=3)
points (aa$C1[aa$ETHNIC=="EUR"], aa$C2[aa$ETHNIC=="EUR"],lwd=2, col=1)
points (aa$C1[aa$ETHNIC=="AFR"], aa$C2[aa$ETHNIC=="AFR"],lwd=2, col=4)
points (aa$C1[aa$ETHNIC=="ASN"], aa$C2[aa$ETHNIC=="ASN"],lwd=2, col=2)

points(0.015, 0.055,lwd=2, col=6)
text(0.015, 0.055, labels="Bio VU", pos=4)
points(0.015, 0.05,lwd=2, col=2)
text(0.015, 0.05, labels="1000 genome ASN", pos=4)
points(0.015, 0.045,lwd=2, col=1)
text(0.015, 0.045, labels="1000 genome EUR", pos=4)
points(0.015, 0.04,lwd=2, col=4)
text(0.015, 0.04, labels="1000 genome AFR ", pos=4)
points(0.015, 0.035,lwd=2, col=3)
text(0.015, 0.035, labels="1000 genome AMR", pos=4)

result<-dev.off()
cat(paste(resultFile,"was successfully generated.\n",sep=""))
