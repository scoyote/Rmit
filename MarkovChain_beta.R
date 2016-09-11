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

tr.m.l <- round(tr.m,1.5)
png(file='//Users//samuelcroker//Documents//github_repositories//Rmit//txgraph.png',width = 2000,height = 2000)
plotmat(tr.m.l, 
        relsize=.7,
        pos=c(1,3,4,3,1),
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


library(ggnet) 
library(network) 
library(sna)
library(ggplot2)
library(RColorBrewer)

#tr.net <- as.network.matrix(tr.m*100, directed=T) #make network object
tr.net = as.network.matrix(tr.m,
              matrix.type = "adjacency",
              directed=T,
              loops=T,
              names.eval = "weights")

  ggnet2(tr.net, label=T),edge.size = "weights")
  
  
         node.size = 12, node.color = "depth", 
         color.palette = "Set2", color.legend = "Water Depth", 
         edge.size = 1, edge.color = "black",
         arrow.size = 1,  arrow.gap = 0.027, 
         legend.size=20)  + 
  guides(color=guide_legend(keyheight=0.5,default.unit="inch",
                            override.aes = list(size=6)))

