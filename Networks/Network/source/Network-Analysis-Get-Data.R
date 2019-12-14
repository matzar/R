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

# Drop 3rd column of the dataframe because it's only a timestamp
dat <- select(dat,-c(3))

dat_tibble <- tibble::as_tibble(dat)
dat_tibble <- select(dat,-c(3))

view(dat_tibble)

dat_tibble <- dat_tibble %>%
  rename(
    from = V1,
    to = V2)

view(dat_tibble)

dat <- dat_tibble

view(dat)

routes_tidy <- tbl_graph(dat, directed = FALSE)
routes_tidy
class(routes_tidy)
g <- graph_from_data_frame(dat, directed=FALSE)
routes_igraph_tidy <- as_tbl_graph(g)
routes_igraph_tidy
class(routes_igraph_tidy)
