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

# creation of data frame
dat_sex <- data.frame("Count" = c("Male" = Male, "Female" = Female))
# checking data frame
str(dat_sex)
head(dat_sex)

# bar chart example
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
head(diamonds)
head(dat)
#bar chart example 2
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# gender in numbers
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = sex, fill = sex))
# subject by gender
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = sex, fill = subject))
#subject by gender with alpha blending
ggplot(data = dat) + 
  geom_bar(alpha = 0.85, mapping = aes(x = sex, fill = subject))
#subject by gender and normalizing using position = "fill"
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = sex, fill = subject), position = "fill")
#subject by gender and normalizing using position = "dodge" to place overlapping objects directly beside one another
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = sex, fill = subject), position = "dodge")
# age by gender
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = age, fill = sex))
# age by subject
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = age, fill = subject))

ggplot(data = dat) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

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




# playground
x <- c(1, 2, 3, 4)
x < 10
CleanedStudentGoalsData[, 3]
colnames(CleanedStudentGoalsData)
CleanedStudentGoalsData$year
class(CleanedStudentGoalsData$year) # returns a vector

