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

# replacing seq column non-consecutive numbers with consecutive numbers
dat$seq <- 1:nrow(dat)
View(dat) # works!
write_csv(dat, "data/StudentGoalsDataCleanedAndNumbered.csv")

# reassing values to their proper labeling from assets/'Student Goals - Coding Information.pdf'
# replace numericals in the 'sex' column with proper sex names
dat$sex[dat$sex==1] <- 'Male'
dat$sex[dat$sex==2] <- 'Female'
# replace numericals in the 'subject' column with proper subject names
dat$subject[dat$subject==1] <- 'Management'
dat$subject[dat$subject==2] <- 'Law'
dat$subject[dat$subject==3] <- 'Tourism'
dat$subject[dat$subject==4] <- 'General Economics'
dat$subject[dat$subject==5] <- 'Accounting'
dat$subject[dat$subject==6] <- 'Statistics'
View(dat)

# save labeled table
write_csv(dat, "data/LabeledAndCleanedStudentGoals.csv")

# check the data's structure
str(dat)
head(dat)

# plot data
Year <- dat[dat$year, ]$seq
plot(Year)
plot(dat[dat$year])
plot(dat[dat$year, ]$seq)


# ggplot data
# ggplot(mpg, aes(displ, hwy, colour = class)) + 
#   geom_point()
ggplot(dat, aes(displ, hwy) +
  geom_point()
# s <- ggplot(CleanedStudentGoalsData, fill=drv)
# s + geom_point()

# playground
x <- c(1, 2, 3, 4)
x < 10
CleanedStudentGoalsData[, 3]
colnames(CleanedStudentGoalsData)
CleanedStudentGoalsData$year
class(CleanedStudentGoalsData$year) # returns a vector

