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


