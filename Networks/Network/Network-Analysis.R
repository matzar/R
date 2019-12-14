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

source("source/Network-Analysis-Get-Data.R")

library(igraph)
library(dplyr)

# Drop 3rd columns of the dataframe
select(dat,-c(3))

# look
head(dat)
str(dat)

# ensure that that the plots take most of the available page space
par(oma=c(0,0,0,0),mar=c(0,0,0,0))

g <- graph_from_data_frame(dat)
gg <- graph.edgelist(dat,directed=FALSE)

plot.igraph(g)
plot.igraph(gg)

summary(g)



# create a network graph
g=graph.adjacency(as.matrix(dat),mode="undirected",
                  weighted=NULL)

summary(g)
