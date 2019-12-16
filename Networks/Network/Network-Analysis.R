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
# library(dplyr)
library(tidyverse)
library(ggraph)
library(tidygraph)
# library(visNetwork)
# library(networkD3)

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

# col
colors.new=rev(rainbow(max(degree(g))+1,end=2/3))
V(g)$color=colors.new[degree(g)+1]

# set vertex size according to degree of each vertex (min. size = 5)
V(g)$size=5+(15)/diff(range(degree(g)))*degree(g)

plot.igraph(g,vertex.label=NA)

colors.new=rev(rainbow(10,end=4/6)) # creates a color palette for us to use
net.close=as.numeric(closeness(g)) # calculates closeness metric for all nodes
net.close=floor((net.close-min(net.close))/diff(range(net.close))*(length(colors.new)-1)+1) # normalises the closeness value
V(g)$color=colors.new[net.close] # sets the color of each node according to the closenss score

net.between=as.numeric(betweenness(g)) # calculates betweenness of each node
net.between=floor((net.between-min(net.between))/diff(range(net.between))*(length(colors.new)-1)+1) # "normalises" the score
V(g)$size=5+(20)/diff(range(net.between))*net.between # sets the node size accoring the betweenness score
plot.igraph(g,vertex.label=NA) # plots the network with these adjustments

# layout for big graphs
area <- vcount(g)^2
layout_with_lgl(g, maxiter = 150, maxdelta = vcount(g),
                area = vcount(g)^2, coolexp = 1.5, repulserad = area *
                  vcount(g), cellsize = sqrt(sqrt(area)), root = NULL)

# plot g with lgl
with_lgl(plot.igraph(g, vertex.label=NA))


# How do we calculate some network metrics using R? Here we will look at calculating some basic network metrics using R.

# A vertex degree is the number of edges going out of (and into) the given vertex. 
# For regular networks, this is a fixed number; often this is a random variable, coming from a certain distribution. 
# A network can be characterised by an average degree.
# Average degree
mean(degree(g))
degree(g)

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
# el=as.matrix(dat)
# el[,1]=as.character(el[,1])
# el[,2]=as.character(el[,2])
# g=graph.edgelist(el,directed=FALSE)
# fixed_layout=layout.kamada.kawai(g) # fixes the layout for your plots
# V(g)$size=5+(15)/diff(range(degree(g)))*degree(g)
# plot.igraph(g,vertex.label.cex=0.0001)

BO_ggraph <- as_tbl_graph(g)
class(BO_ggraph)
class(g)

BO_ggraph %>% 
  activate(edges)

ggraph(BO_ggraph) +
  geom_edge_link(aes(colour = factor(timestamp))) + 
  geom_node_point()

ggraph(g) +
  geom_edge_link(aes(colour = factor(timestamp))) + 
  geom_node_point()

ggraph(g) + geom_edge_link() + geom_node_point() + theme_graph()
ggraph(BO_ggraph) + geom_edge_link() + geom_node_point() + theme_graph()

# Create graph of highschool friendships
graph <- as_tbl_graph(highschool) %>% 
  mutate(Popularity = centrality_degree(mode = 'in'))

# set degree of the graph
V(g)$degree <- degree(g)

# plot using ggraph
ggraph(g, layout = 'kk') + 
  geom_edge_fan(show.legend = TRUE) + 
  geom_node_point(aes(size = degree(g))) +
  scale_edge_color_brewer(palette = 'Dark2') +
  theme_void()
# ###
library(tweenr)
igraph_layouts <- c('star', 'circle', 'gem', 'dh', 'graphopt', 'grid', 'mds',
                    'randomly', 'fr', 'kk', 'drl', 'lgl')
igraph_layouts <- sample(igraph_layouts)
graph <- graph_from_data_frame(dat)
V(graph)$degree <- degree(graph)
layouts <- lapply(igraph_layouts, create_layout, graph = graph)
layouts_tween <- tween_states(c(layouts, layouts[1]), tweenlength = 1,
                              statelength = 1, ease = 'cubic-in-out',
                              nframes = length(igraph_layouts) * 16 + 8)
title_transp <- tween_t(c(0, 1, 0, 0, 0), 16, 'cubic-in-out')[[1]]
for (i in seq_len(length(igraph_layouts) * 16)) {
  tmp_layout <- layouts_tween[layouts_tween$.frame == i, ]
  layout <- igraph_layouts[ceiling(i / 16)]
  title_alpha <- title_transp[i %% 16]
  p <- ggraph(graph, 'manual', node.position = tmp_layout) +
    geom_edge_fan(aes(alpha = ..index.., colour = factor(year)), n = 15) +
    geom_node_point(aes(size = degree)) +
    scale_edge_color_brewer(palette = 'Dark2') +
    ggtitle(paste0('Layout: ', layout)) +
    theme_void() +
    theme(legend.position = 'none',
          plot.title = element_text(colour = alpha('black', title_alpha)))
  plot(p)
}
# https://www.jessesadler.com/post/network-analysis-with-r/
# http://networkrepository.com/rt.php
