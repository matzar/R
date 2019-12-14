# download
pth <- "http://nrvis.com/download/data/rt/rt-pol.zip"
download.file(pth, destfile = "rt-pol.zip")

# see file names
# unzip("socfb-Berkeley13.zip", list = TRUE)

# unzip
unz <- unzip("rt-pol.zip", "rt-pol.txt")


# quick look : looks like edge list
readLines(unz, n=10)

# skip first line to avoid % bipartite unweighted" 
# dat <- read.table(unz, skip=1, sep=",")
dat <- read.table(unz, sep=",")

# look
head(dat)
str(dat)

# load as a graph
library(igraph)

g <- graph_from_data_frame(dat)
g

summary(g)


