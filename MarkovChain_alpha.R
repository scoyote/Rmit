#ct <- read.csv("//Users//samuelcroker//Desktop//ct.csv", stringsAsFactors = F)
ct <- read.csv("//Users//samuelcroker//OneDrive//SAS//RIntegration/MARKOVPREP.csv", stringsAsFactors = F)
ct.m <- t(table(ct[,c(2,3)]))
tr.m <- prop.table(ct.m,1)

#ct <- subset(ct, pdrg != "    -")

slices <- 10
ct.f <- array(data=rep(0,12*12*slices),c(12,12,slices))
dimnames(ct.f)<- list(colnames(ct.m),rownames(ct.m))
ct.f[,,1] <- ct.m
for(i in 2:slices){
  ct.f[,,i] <- as.matrix(ct.f[,,i-1]) %*% tr.m 
}

for(i in seq(1,12,1)){
  for(j in seq(1,12,1)){
    if(i==1 & j==1){
      plot.df <- as.data.frame(t(ct.f[i,j,]),dimnames=list(colnames(ct.f)))
    }
    else plot.df <- rbind(plot.df,as.data.frame(t(ct.f[i,j,])))
    #print(ct.f[i,j,])
  }
}
plot.df <- cbind(data.frame(x=seq(1,slices)),t(plot.df))

colnames(plot.df) <- paste("V",colnames(plot.df),sep='')


library(ggplot2) 

var <- "V2"
ggplot(data=plot.df) + geom_line(aes_string(y=var, x="Vx")) 
plotline <- "ggplot(data=plot.df) + geom_line(aes(y=V2, x=Vx)) "

ggplot(data=plot.df) + geom_line(aes(y=V2, x=Vx)) + 
  geom_line(aes(y=V1, x=Vx)) + 
  geom_line(aes(y=V2, x=Vx)) +
  geom_line(aes(y=V3, x=Vx)) +
  geom_line(aes(y=V4, x=Vx)) +
  geom_line(aes(y=V12, x=Vx)) +
  geom_line(aes(y=V14, x=Vx)) +
  geom_line(aes(y=V16, x=Vx)) +
  geom_line(aes(y=V18, x=Vx)) +
  geom_line(aes(y=V22, x=Vx)) +
  geom_line(aes(y=V24, x=Vx)) +
  geom_line(aes(y=V26, x=Vx)) +
  geom_line(aes(y=V28, x=Vx)) +
  geom_line(aes(y=V30, x=Vx)) +
  geom_line(aes(y=V32, x=Vx)) +
  geom_line(aes(y=V34, x=Vx)) +
  geom_line(aes(y=V36, x=Vx)) +
  geom_line(aes(y=V38, x=Vx)) +
  geom_line(aes(y=V40, x=Vx)) 

library(reshape)


mdata <- melt(plot.df, id=c("id","time"))