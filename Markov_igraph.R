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


library(igraph)

tr.net = as.network(pl.m*100,
                 matrix.type = "adjacency",
                 directed=T,
                 loops=T,
                 names.eval = "weights",
                 ignore.eval = F)

tr.degree <- igraph::degree(tr.gm,mode='in')

tr.gm <- graph.adjacency(pl.m,weighted=T,mode='directed')


E(tr.gm)$color <- ifelse(substr(apply(get.edgelist(tr.gm), 1, paste, collapse="-"),13,13)=='Y','pink','lightsteelblue1')
E(tr.gm)$width <- log(E(tr.gm)$weight*10000)
V(tr.gm)$size <- igraph::degree(tr.gm,mode='out')
plot(tr.gm,edge.curved=.1,layout=layout_in_circle)