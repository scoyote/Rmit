# this program requires MarkovChain_alpha.R

ct <- read.csv("//Users//samuelcroker//OneDrive//SAS//RIntegration/MARKOVPREP.csv", stringsAsFactors = F)
ct.m <- t(table(ct[,c(2,3)]))
tr.m <- prop.table(ct.m,1)

stateNames <- colnames(ct.m)

row.names(ct.m) <- stateNames
colnames(ct.m) <- stateNames

row.names(tr.m) <- stateNames
colnames(tr.m) <- stateNames

tr.m.l <- round(tr.m,3)
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