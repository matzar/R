# download
pth <- "http://nrvis.com/download/data/rt/rt-pol.zip"
download.file(pth, destfile = "rt-pol.zip")

# see file names
unzip("socfb-Berkeley13.zip", list = TRUE)

# unzip
unz <- unzip("rt-pol.zip", "rt-pol.txt")

# quick look : looks like edge list
readLines(unz, n=10)

dat <- read.table(unz, sep=",")