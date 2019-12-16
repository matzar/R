# download
pth <- "http://nrvis.com/download/data/rt/rt_barackobama.zip"
download.file(pth, destfile = "rt_barackobama.zip")

# see file names
unzip("rt_barackobama.zip", list = TRUE)

# unzip
unz <- unzip("rt_barackobama.zip", "rt_barackobama.edges")

dat <- read.table(unz, sep=",")

# save as csv to use in python
write.csv(dat,"barack_obama.csv", row.names = FALSE)

# Drop 3rd column (V3) of the dataframe because it's only a timestamp
dat <- select(dat,-c(3))
dat <- dat %>%
  rename(
    from = V1,
    to = V2
  )
view(dat)

edges <- dat
# rename edge list
edges <- edges %>%
  rename(
    from = V1,
    to = V2)
view(edges)

# add id column
nodes <- tibble::rowid_to_column(dat, "id")
nodes <- data.frame(nodes)
nodes <- nodes %>%
  rename(
    id = nodes
  )
view(nodes)

#visNetwork(nodes, edges)

g <- graph_from_data_frame(dat, directed=FALSE)
g
plot.igraph(g)

# gg <- graph_from_data_frame(d = edges, vertices = nodes, directed = FALSE)
# gg

# graph <- graph_from_data_frame(highschool)
# graph
# summary(graph)
# ggraph(graph) + 
#   geom_edge_link(aes(colour = factor(year))) + 
#   geom_node_point()
# view(highschool)
