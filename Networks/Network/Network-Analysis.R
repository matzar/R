install.packages("igraph", dependencies=TRUE, repos='http://cran.rstudio.com/')

options(download.file.method = "wget")
install.packages("igraph")
library(igraph)


# download
pth <- "http://nrvis.com/download/data/misc/actor-movie.zip"
download.file(pth, destfile = "actor-movie.zip")

# see file names
unzip("actor-movie.zip", list = TRUE)

# unzip
unz <- unzip("actor-movie.zip", "actor-movie.edges")

# quick look : looks like edge list
readLines(unz, n=10)

# skip first line to avoid % bipartite unweighted" 
dat <- read.table(unz, skip=1, sep=",")

# look
head(dat)
str(dat)

g <- graph_from_data_frame(dat)
g

# References 
# https://stackoverflow.com/questions/58350400/how-to-read-in-edges-file-in-r