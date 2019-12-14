# download
pth <- "http://nrvis.com/download/data/rt/rt-pol.zip"
download.file(pth, destfile = "rt-pol.zip")

# see file names
unzip("socfb-Berkeley13.zip", list = TRUE)

# unzip
unz <- unzip("rt-pol.zip", "rt-pol.txt")

# TODO remove
# quick look : looks like edge list
# readLines(unz, n=10)

dat <- read.table(unz, sep=",")

# remove first line
# dat <- read.table(unz, skip=1, sep=",")

# Drop 3rd column (V3) of the dataframe because it's only a timestamp
dat <- select(dat,-c(3))
edges <- dat
# rename edge list
edges <- edges %>%
  rename(
    from = V1,
    to = V2)
view(edges)

# add id column
nodes <- tibble::rowid_to_column(dat, "id")
view(nodes)

visNetwork(nodes$id, edges)

g <- graph_from_data_frame(dat, directed=FALSE)
g

ggraph(g) + 
  geom_edge_link(aes(colour = factor(timestamp))) + 
  geom_node_point()

graph <- graph_from_data_frame(highschool)
graph
summary(graph)
ggraph(graph) + 
  geom_edge_link(aes(colour = factor(year))) + 
  geom_node_point()
view(highschool)
