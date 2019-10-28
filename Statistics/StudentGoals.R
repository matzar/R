# install.packages("readr")
# library(readr)
library(tidyverse)

# read csv file (worse variable recognition)
f <- "data/StudentGoalsData.csv"
StudentGoalsData <- read_csv(f)

# read csv file
# StudentGoalsData <- data.table::fread("data/StudentGoalsData.csv") # fread - better variable recognition

# clean data
CleanedStudentGoalsData <- drop_na(StudentGoalsData)

# write cleaned data to a file
write_csv(CleanedStudentGoalsData, "data/CleanedStudentGoalsData.csv")

# view data to check if it's been cleaned
View(StudentGoalsData)
View(CleanedStudentGoalsData)

# save CleanedStudentGoalsData table in a simple variable called dat
dat <- CleanedStudentGoalsData

# after cleaning seq column contains non-consecutive numbers 
# replace seq column's numbers with consequetive numbers 
dat$seq <- 1:nrow(dat)
View(dat)

# check the data's structure
str(CleanedStudentGoalsData) # uses int
head(CleanedStudentGoalsData)
str(dat)

View(dat)
# plot data
data <- CleanedStudentGoalsData
plot(data[data$year])
plot(data[data$year, ]$seq)
s <- data[data$year, ]$seq

# ggplot data
# ggplot(mpg, aes(displ, hwy, colour = class)) +
# geom_point()
# s <- ggplot(CleanedStudentGoalsData, fill=drv)
# s + geom_point()

# playground
x <- c(1, 2, 3, 4)
x < 10
CleanedStudentGoalsData[, 3]
colnames(CleanedStudentGoalsData)
CleanedStudentGoalsData$year
class(CleanedStudentGoalsData$year) # returns a vector

