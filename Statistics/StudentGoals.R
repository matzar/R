# install.packages("readr")
# library(readr)
library(tidyverse)

# read csv file (worse variable recognition)
# f <- "data/StudentGoalsData.csv"
# StudentGoalsData <- read_csv(f)

# read csv file
StudentGoalsData <- data.table::fread("data/StudentGoalsData.csv") # fread - better variable recognition

# clean data
CleanedStudentGoalsData <- drop_na(StudentGoalsData)

# write cleaned data to a file
write_csv(CleanedStudentGoalsData, "data/CleanedStudentGoalsData.csv")

# view data to check if it's been cleaned
View(StudentGoalsData)
View(CleanedStudentGoalsData)

# check the data's structure
str(CleanedStudentGoalsData) # uses int

# 


# plot 
# ggplot(mpg, aes(displ, hwy, colour = class)) +
# geom_point()
# s <- ggplot(CleanedStudentGoalsData, fill=drv)
# s + geom_bar()

