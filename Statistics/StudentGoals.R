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
# plot(dat[dat$year, ]$seq)

# variables
seq <- dat$seq
year <- dat$year
age <- dat$age
sex <- dat$sex
sub <- dat$subject
# q1 ... q12
interest <- dat$interest
enjoy <- dat$enjoy
mg <- dat$mastgrad

# numeric variables
Male <- sum(dat$sex=='Male')
Female <- sum(dat$sex=='Female')

# g <- ggplot(dat, aes(Male, Female, colour = sex))
# g <- gplot(mpg, aes(class, hwy))
# g + geom_count()
qplot(x = Male, y = Female, data = dat, geom = "count", colour = sex)
qplot(x = Male, y = Female, data = dat, geom = "col", colour = sex)
qplot(x = Male, y = Female, data = dat, geom = "dotplot", colour = sex)

d <- ggplot(dat, aes(Male, Female, colour = sex))
d + geom_count()

dat_sex <- data.frame("Count" = c("Male" = Male, "Female" = Female))
# gender <- data.frame("Gender" = c(Male, Female))
str(dat_sex)
head(dat_sex)

ggplot(data = dat_sex) + 
  geom_bar(mapping = aes(x = Count))

d <- ggplot(dat_sex, aes())
d + geom_bar(x = 0)

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

head(diamonds)
head(dat)
# gender in numbers
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = sex, fill = sex))
# subject by gender
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = sex, fill = subject))
# age by gender
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = age, fill = sex))
# age by subject
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = age, fill = subject))

# course year by gender
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = year, fill = sex))
# "expect my courses this semester to be very interesting" by gender
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = interest, fill = sex))
# "expect my courses this semester to be very enjoyable" by gender
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = enjoy, fill = sex))
# relative importance by gender
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = mastgrad, fill = sex))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# ggplot data
ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point()
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

