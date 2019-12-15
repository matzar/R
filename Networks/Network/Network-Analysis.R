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

library(igraph)
library(dplyr)
library(tidyverse)
library(ggraph)
library(tidygraph)
library(visNetwork)
library(networkD3)

source("source/Network-Analysis-Get-Data.R")


ggraph(g)

# look
head(dat)
str(dat)
g <- graph_from_data_frame(dat, directed=FALSE)
summary(g)
g
# view(dat)

# ensure that that the plots take most of the available page space
par(oma=c(0,0,0,0),mar=c(0,0,0,0))
# plot graph
plot.igraph(g)

# How do we calculate some network metrics using R? Here we will look at calculating some basic network metrics using R.

# A vertex degree is the number of edges going out of (and into) the given vertex. 
# For regular networks, this is a fixed number; often this is a random variable, coming from a certain distribution. 
# A network can be characterised by an average degree.
# Average degree
mean(degree(g))

# The clustering coefficient is a measure of the “all-my-friends-know-each-other” property. 
# Clusterin
transitivity(g)

# Average path length is calculated by finding the shortest path between all pairs of vertices, 
# adding them up, and then dividing by the total number of pairs. 
# This shows us, on average, the number of steps it takes to get from one member of the network to another. 
# Average path length
average.path.length(g)


# closeness centrality
colors.new=rev(rainbow(10,end=2/3))
net.close=as.numeric(closeness(g)) 
net.close=floor((net.close-min(net.close))/diff(range(net.close))*(length(colors.new)-1) +1)
c = V(g)$color=colors.new[net.close]

net.close=as.numeric(betweenness(g))

plot.igraph(g, label=0.0001)

###########################################################
el=as.matrix(dat)
el[,1]=as.character(el[,1])
el[,2]=as.character(el[,2])
g=graph.edgelist(el,directed=FALSE)
fixed_layout=layout.kamada.kawai(g) # fixes the layout for your plots
V(g)$size=5+(15)/diff(range(degree(g)))*degree(g)
plot.igraph(g,vertex.label.cex=0.0001)

# https://www.jessesadler.com/post/network-analysis-with-r/
# http://networkrepository.com/rt.php
