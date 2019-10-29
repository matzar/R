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
tibble_dat <- tibble::as_tibble(CleanedStudentGoalsData)
view(tibble_dat)

# Sorting questions (NOT NEEDED)
# Moving columns to sort questions accordingly to
# order (question number): 6, 12, 11, 1, 7, 2, 10, 8, 5, 3, 9, 4
# col_order <- c("seq", "year", "age", "sex", "subject", 
#                "q4", "q6", "q10", "q12", "q9", "q1", 
#                "q5", "q8", "q11", "q7", "q3", "q2",
#                "interest", "enjoy", "mastgrad")
# reordered_data <- tibble_dat[, col_order]

# Renaming columns according to random order: 6, 12, 11, 1, 7, 2, 10, 8, 5, 3, 9, 4
renamed_data <- tibble_dat %>%
  rename(
    Q6 = q1,
    Q12 = q2,
    Q11 = q3,
    Q1 = q4, 
    Q7 = q5, 
    Q2 = q6, 
    Q10 = q7, 
    Q8 = q8, 
    Q5 = q9, 
    Q3 = q10, 
    Q9 = q11, 
    Q4 = q12
  )
view(renamed_data)
# going back to lower case 'q' to keep naming consistent with the original data set
renamed_data2 <- renamed_data %>%
  rename(
    q1 = Q1, q2 = Q2, q3 = Q3, q4 = Q4, q5 = Q5, q6 = Q6, 
    q7 = Q7, q8 = Q8, q9 = Q9, q10 = Q10, q11= Q11, q12 = Q12
  )
view(renamed_data2)
dat <- renamed_data2
view(dat)

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
# Year <- dat[dat$year, ]$seq
# plot(Year)
# plot(dat[dat$year, ]$seq)

# variables
# seq <- dat$seq
# year <- dat$year
# age <- dat$age
# sex <- dat$sex
# sub <- dat$subject
# q1 ... q12
# interest <- dat$interest
# enjoy <- dat$enjoy
# mg <- dat$mastgrad

# numeric variables
# Male <- sum(dat$sex=='Male')
# Female <- sum(dat$sex=='Female')

# creation of data frame
# dat_gender <- data.frame("Count" = c("Male" = Male, "Female" = Female))
# checking data frame
# str(dat_gender)
# head(dat_gender)

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

#subject by gender and normalizing using position = "dodge" to place overlapping objects directly beside one another
ggplot(data = dat) + 
  geom_bar(mapping = aes(x = sex, fill = subject), position = "dodge")

# plot answers to q1 with relation to the student's year
ggplot(data = dat) + 
  geom_point(mapping = aes(x = seq, y = q1, colour = year))

# TODO - example
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_colour_brewer(palette = "Set1")
# TODO - working colouring
ggplot(dat, aes(seq, q1)) + geom_point(aes(color = sex), position = "jitter") +
  scale_colour_brewer(palette = "Set3")

# plot answers to q1 with relation to the student's year, use "jitter" to improve the graph and avoid gridding
# data
ggplot(dat, aes(year, q1))
# saving data into a variable
d <- ggplot(data = dat, aes(year, q1))

# mapping data with no subject label
d + geom_jitter(aes(colour = year, shape = subject))
# adding dark theme
temp <- d + geom_jitter(aes(colour = year)) + theme_dark()
# adding labels
temp + labs(
  title = "Answers to question 1 with relation to student's year",
  caption = "Data from canvas",
  x = "Student num",
  y = "Answer (1-7)",
  colour = "Year"
)
temp <- temp + labs(
  title = "Answers to question 1 with relation to student's year",
  caption = "Data from canvas",
  x = "Student num",
  y = "Answer (1-7)",
  colour = "Year"
)

## Statistical Data Analysis of Student Goals ##
# Recent evidence has shown that across a range of subject areas, 
# undergraduates have different reasons for studying as they progress through
# their degree programs. 
# 1) Students initially focus on understanding (mastery goals) and
# move to a more grade-oriented focus (performance goals) 
# in later years and 
# 2) students tend to demonstrate greater intrinsic motivation (e.g., 
# interest and enjoyment) during their earlier studies rather than 
# during the latter stages of their programmes.
# The aim of this research is to examine whether this is the case, 
# whether this differs for different subjects and/or different genders.

# Mann-Whitney-Wilcoxon Test
# wilcox.test(mpg ~ am, data=mtcars) 

# data
ggplot(dat, aes(year, q1))
# saving data into a variable
d <- ggplot(data = dat, aes(year, q1))
# mapping data with subject label
d + geom_jitter(aes(colour = subject, shape = sex))
# save mapping
o <- d + geom_jitter(aes(colour = subject, shape = sex))
# o <- d + geom_point(mapping = aes(x = seq, y = q1, colour = year), position = "jitter")
# adding dark theme
o + theme_dark()
# save
p <- o + theme_dark()
# adding labels
p + labs(
  title = "1. My goal in this class is to avoid performing poorly",
  subtitle = "1. It is important to me to be better than other students",
  caption = "Journal of Personality and Social Psychology, 80, 3, 501-519",
  x = "Year",
  y = "Answer (1-7)",
  colour = "Subject",
  shape = "Gender"
) + theme(legend.position = "right")
# adding colour
# scale_colour_brewer(palette = "YlOrRd")

# Packages used to calculate confidence interval for proportions
# install.packages(c("binom", "Barnard"))


# # save
# t <- p + labs(
#   title = "1. My goal in this class is to avoid performing poorly",
#   subtitle = "It is important to me to be better than other students",
#   caption = "Journal of Personality and Social Psychology, 80, 3, 501-519",
#   x = "Year",
#   y = "Answer (1-7)",
#   colour = "Subject",
#   shape = "Gender"
# )
# # adding colour
# t + scale_colour_brewer(palette = "YlOrRd")

# t + geom_label(aes(label = year), data = dat, alpha = 0.5)
# t + geom_jitter(size = 3, shape = 1, data = dat) +
# #   ggrepel::geom_label_repel(aes(label = year), data = dat)
# 
# class_avg <- dat %>%
#   group_by(subject) %>%
#   summarise(
#     seq = median(seq),
#     q1 = median(q1)
#   )
# 
# ggplot(dat, aes(seq, q1, colour = year)) +
#   ggrepel::geom_label_repel(aes(label = subject),
#                             data = dat,
#                             size = 6,
#                             label.size = 0,
#                             segment.color = NA
#   ) +
#   geom_point() +
#   theme(legend.position = "none")

# mapping answers to q1 with relation to the student's year
dd <- ggplot(data = dat, mapping = aes(x = seq, y = q1))
# box plot
dd + geom_boxplot() + coord_flip()

# bar plot
bar <- ggplot(data = dat) + 
  geom_bar(
    mapping = aes(x = sex, fill = subject, alpha = 0.85), 
    show.legend = TRUE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar() + theme_dark()

# plot answers to q1 with relation to the student's subject
ggplot(data = dat) + 
  geom_point(mapping = aes(x = seq, y = q1, colour = subject))
# plot answers to q1 with relation to the student's subject, uses "jitter" to improve the graph and avoid gridding
ggplot(data = dat) + 
  geom_jitter(mapping = aes(x = seq, y = q1, colour = subject))


# playground
x <- c(1, 2, 3, 4)
x < 10
CleanedStudentGoalsData[, 3]
colnames(CleanedStudentGoalsData)
CleanedStudentGoalsData$year
class(CleanedStudentGoalsData$year) # returns a vector

