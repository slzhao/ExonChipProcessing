dataFile<-commandArgs()[6]
resultFile<-commandArgs()[7]

d2 <- read.table(dataFile,header=T,as.is=T)
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
        usr <- par("usr"); on.exit(par(usr))
        par(usr = c(0, 1, 0, 1))
        r <- abs(cor(x, y,method="spearman"))
        txt <- format(c(r, 0.123456789), digits=digits)[1]
        txt <- paste(prefix, txt, sep="")
        if(missing(cex.cor)) cex.cor <- 0.4/strwidth(txt)
        text(0.5, 0.5, txt, cex = cex.cor * r)
}

N=(ncol(d2)-2)/3
mblack<-d2[,3*(1:N)+1,drop=F]
colnames(mblack) <-  c(paste("Batch", 1:N, sep=""))
jpeg(resultFile, res=300, width=5, height=5, units="in")
pairs(mblack,main="Allele Frequency in European Ancestry",lower.panel=panel.smooth, upper.panel=panel.cor)
result<-dev.off()
cat(paste(resultFile," was successfully generated.\n",sep=""))

