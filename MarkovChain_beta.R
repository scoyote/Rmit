# this program requires MarkovChain_alpha.R
library(diagram)
ct <- read.csv("//Users//samuelcroker//OneDrive//SAS//RIntegration/MARKOVPREP.csv", stringsAsFactors = F)
ct.m <- t(table(ct[,c(2,3)]))
tr.m <- prop.table(ct.m,1)

stateNames <- colnames(ct.m)

row.names(ct.m) <- stateNames
colnames(ct.m) <- stateNames

row.names(tr.m) <- stateNames
colnames(tr.m) <- stateNames

tr.m.l <- round(tr.m,2)

pl.m <- tr.m
pl.m[c(1,3,5,7,9,11),c(1,3,5,7,9,11)] <- 0
png(file='txgraph.png',width = 2000,height = 2000)
plotmat(pl.m, 
        relsize=.7,
        #pos=c(1,3,4,3,1),
        lwd = 0.5, box.lwd = 2, 
        cex.txt = 0.8, 
        box.size = 0.1, 
        box.type = "circle", 
       box.prop = 0.5,
        box.col = "light yellow",
        arr.length=.1,
        arr.width=.1,
        self.cex = .4,
        self.shifty = -.01,
        self.shiftx = .13,
        main = "")
dev.off()

library(igraph)
g <- graph.adjacency(tr.m,weighted=T)
g.df <- get.data.frame(g)
colnames(g.df) <- list("source","target","weight")
write.csv(g.df, file='network.csv',row.names = F)


library(GGally) 
library(network) 
library(sna)
library(ggplot2)
library(RColorBrewer)


#tr.net <- as.network.matrix(tr.m*100, directed=T) #make network object
tr.net = network(pl.m*100,
              matrix.type = "adjacency",
              directed=T,
              loops=F,
              names.eval = "weights",
              ignore.eval = F)
#fruchtermanreingold
#set.edge.attribute(tr.net, "color", ifelse(tr.net %e% "weights" > 2, "grey75", "black"))
  
ggnet2(tr.net,
         mode = "circle",
         label=T,
         size = 'degree',
         arrow.gap = .1,
         edge.size = "weights",
         node.color = ifelse(substr(network.vertex.names(tr.net),6,6) == 'Y', "red", "grey75"),
         edge.color = ifelse(tr.net %e% "weights" > 1, "grey75", "red"),
         arrow.size = 12
         )

  


