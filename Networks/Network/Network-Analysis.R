# Introduction (25%):
#   Provide some background to the network data set you have selected. 
#   What is interesting about this data set? Where was it available? What questions do you wish to answer using this network?
#   
# Methods (25%):
#   What are the nodes and edges in this network? 
#   What network metrics will you try to calculate for this data? (Include your code as an appendix)
# 
# Results (25%): 
#   Perhaps a visualisation of the network, appropriate results for the questions set in the introduction.
# 
# Conclusion (25%):
#   What did your analysis tell you? Could you answer your questions, and if so, what were the answers? 
#   Did you encounter any problems dealing with a large data set? What were they? 
#   Are there things you could have done to avoid them? Was the data detailed enough? 
#   Was it of good enough quality? Was the data set of an appropriate size?


## DATA
# Category	Sparse Networks
# Collection	Interaction Networks
# Tags	
# Retweetsinteraction networktwitter
# Short	Retweet network
# Vertex type	User
# Edge type	Retweet
# Format	Undirected
# Edge weights	Unweighted
# Description	Nodes are Twitter users and edges represent whether the users have retweeted each other. 
# Third column represents the timestamp of the edge.

## TODO remove ## skip first line to avoid % bipartite unweighted" 
## TODO uncomment
## download
# pth <- "http://nrvis.com/download/data/rt/rt-pol.zip"
# download.file(pth, destfile = "rt-pol.zip")

# see file names
# unzip("socfb-Berkeley13.zip", list = TRUE)

## unzip
# unz <- unzip("rt-pol.zip", "rt-pol.txt")

## quick look : looks like edge list
# readLines(unz, n=10)

# dat <- read.table(unz, sep=",")

## look
# head(dat)
# str(dat)

## load as a graph
# library(igraph)

# g <- graph_from_data_frame(dat)
## TODO uncomment

head(dat)
str(dat)

g

summary(g)
