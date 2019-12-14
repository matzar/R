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
library(tidyverse)

# dat <- read.table(unz, sep=",")
dat_tibble <- tibble::as_tibble(dat)
dat <- dat_tibble %>%
  rename(
    from = V1,
    to = V2)

# Drop 3rd column of the dataframe
dat <- select(dat,-c(3))

# look
head(dat)
str(dat)
g <- graph_from_data_frame(dat)
summary(g)
view(dat)

# ensure that that the plots take most of the available page space
par(oma=c(0,0,0,0),mar=c(0,0,0,0))

# gg <- graph.edgelist(dat,directed=FALSE)

# plot.igraph(g)
# plot.igraph(gg)
# plot.igraph(g,layout=layout.circle,
#             vertex.label=V(g)$name,vertex.size=5,
#             vertex.label.color="red",vertex.label.font=2,
#             vertex.color="blue",edge.color="black")




# create a network graph
g=graph.adjacency(as.matrix(dat),mode="directed",
                  weighted=NULL)

summary(g)
