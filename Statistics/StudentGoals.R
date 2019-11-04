# copyright: Mateusz Zaremba 2019
# contact: mat.zar@icloud.com

library(tidyverse)
library(modelr)
library(rsample)
library(broom)
library(magrittr)
library(plotly)

# set seed for randomization to ensure that results are always reproduced precisely
set.seed(1234)

# disable warnings for the sake of debugging
options(warn=0)

# read csv file (worse variable recognition)
f <- "data/StudentGoalsData.csv"
StudentGoalsData <- read_csv(f, col_types = cols(), skip_empty_rows = TRUE)

# drop 'seq' column since it doesn't serve any purpose
StudentGoalsData <- StudentGoalsData  %>%  ungroup  %>%  select(-seq)

# count all the students before cleaning and dropping the data
n <- tally(StudentGoalsData)

# read csv file with fread - better variable recognition
# StudentGoalsData <- data.table::fread("data/StudentGoalsData.csv")

# clean data - drop results contaiting empty cells
CleanedStudentGoalsData <- drop_na(StudentGoalsData)

# write cleaned data to a file
write_csv(CleanedStudentGoalsData, "data/CleanedStudentGoalsData.csv")

# save CleanedStudentGoalsData table in a simple variable called 'dat'
dat <- CleanedStudentGoalsData

# save CleanedStudentGoalsData table as tibble table in a variable called 'dat_tibble'
dat_tibble <- tibble::as_tibble(CleanedStudentGoalsData)

# Renaming columns according to random order: 6, 12, 11, 1, 7, 2, 10, 8, 5, 3, 9, 4
renamed_data <- dat_tibble %>%
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
# going back to lower case 'q' to keep naming consistent with the original data set
renamed_data2 <- renamed_data %>%
  rename(
    q1 = Q1, q2 = Q2, q3 = Q3, q4 = Q4, q5 = Q5, q6 = Q6, 
    q7 = Q7, q8 = Q8, q9 = Q9, q10 = Q10, q11= Q11, q12 = Q12
  )
# save renamed table in 'dat' variable
dat <- renamed_data2
# save new data in a csv file
write_csv(dat, "data/StudentGoalsDataCleanedAndNumbered.csv")

# renaming values to their proper labeling from assets/'Student Goals - Coding Information.pdf'
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

# save new labeled table to a csv file
write_csv(dat, "data/LabeledAndCleanedStudentGoals.csv")

## DATA EXPLORATION ##################################################################
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
  geom_point(mapping = aes(x = year, y = q1, colour = year))
##############################################################################

## Calculate mean for 7 categories:
# across 7 categories:
# - q1, q2, q3 - Performance approach questions
# - q4, q5, q6 - Performance avoidance questions
# - q7, q8, q9 - Mastery-Approach
# - q10, q11, q12 - Mastery-Avoidance
# - Interest
# - Enjoyment
# - Understanding/Grades

mean_dat <- dat
# get mean from q1, q2, q3 columns (Performance approach questions) for all the students
# save the results in 'm1' colum and add it to 'mean_dat' table
mean_dat <- mean_dat %>% 
  mutate(m1 = pmap_dbl(select(., c("q1", "q2", "q3")), function(...) mean(c(...))))

# get mean from q4, q5, q6 columns (Performance avoidance questions) for all the students,
# save the results in 'm2' colum and add it to 'mean_dat' table
mean_dat <- mean_dat %>% 
  mutate(m2 = pmap_dbl(select(., c("q4", "q5", "q6")), function(...) mean(c(...))))

# get mean from q7, q8, q9 columns (Mastery approach questions) for all the students
# save the results in 'm3' colum and add it to 'mean_dat' table
mean_dat <- mean_dat %>% 
  mutate(m3 = pmap_dbl(select(., c("q7", "q8", "q9")), function(...) mean(c(...))))

# get mean from q10, q11, q12 columns (Mastery avoidance questions) for all the students 
# save the results in 'm4' colum and add it to 'mean_dat' table
mean_dat <- mean_dat %>% 
  mutate(m4 = pmap_dbl(select(., c("q10", "q11", "q12")), function(...) mean(c(...))))

# save final cleaned table
write_csv(mean_dat, "data/MeanCleanedStudentGoals.csv")
# save final cleaned table as tibble table
dat_tibble <- as_tibble(mean_dat)

## CLASSIFICATION ###################################################
# dat_tibble %>%
#   head() %>%
#   knitr::kable()

# get only answers that are greater or equal to 5
dat_tibble_m1 <- filter(dat_tibble, m1 >= 5)

n_m1 <- tally(dat_tibble_m1) # 212
beta <- n_m1 / n # 0.3392

ci <- beta * ((1 - beta)/(n)) # 0.0003586294
ci_sqrt <- sqrt(ci) # 0.0189
ci_margin_error <- ci_sqrt * 1.96 # 0.0371 or 3.71% 

# Our 95% confidence interval for the percentage of times we will get a student with a mean of
# 5 or above for the set of m1 questions is 0.3392 (or 34%), plus or minus 0.03711 (or 3.7%).
# The lower end of the interval is 0.3392 - 0.03711 which is:
lower_end_of_interval <- beta - ci_margin_error # 0.3020825 or 30%
# The upper end of the interval is 0.3392
upper_end_of_interval <- beta + ci_margin_error # 0.3763175 or 37%

# To interpret these results we could say that with 95% confidence the percentage of the times
# we should expect to find a student with a mean score of 5 or above to m1 is somewhere
# between 30% and 37%, based on our sample.
#####################################################################

# m1
# Plot mean results of performance approach questions
# for all students with relation to student's year, sex and subject
# data
d <- ggplot(data = dat, aes(mean_dat$year, mean_dat$m1))
# mapping data (use "jitter" to improve the graph and avoid gridding)
l <- d + geom_jitter(aes(colour = sex, shape = subject))
# smoothing
s <- l + geom_smooth(method = loess, formula = y ~ x, se = TRUE)
# adding theme
t <- s + theme_dark()
# adding colouring
c <- t + scale_colour_brewer(palette = "Pastel1")
# adding labels
c + labs(
  title = "Student's grade-orientation focus set on basis of:
different years of study, sexes and subjects.",
  subtitle = "How important it is to students to do better than others?",
  caption = "Data source: Elliot, A. J. and McGregor, H. A. (2001)",
  x = "Year (1-4)",
  y = "Answer: 1 (Low) - 7 (High)",
  colour = "Sex",
  shape = "Subject"
)

# m2
# Plot mean results of performance avoidance
# for all students with relation to student's year, sex and subject
# data
d <- ggplot(data = dat, aes(year, mean_dat$m2))
# mapping data (use "jitter" to improve the graph and avoid gridding)
l <- d + geom_jitter(aes(colour = sex, shape = subject))
# smoothing
s <- l + geom_smooth(method = loess, formula = y ~ log(x), se = TRUE)
# adding theme
t <- s + theme_dark()
# adding colouring
c <- t + scale_colour_brewer(palette = "Pastel1")
# adding labels
c + labs(
  title = "Student's grade-orientation focus set on basis of:
different years of study, sexes and subjects.",
  subtitle = "How motivated are students by fear of performing poorly?",
  caption = "Data source: Elliot, A. J. and McGregor, H. A. (2001)",
  x = "Year: 1 - 4",
  y = "Answer: 1 (Low) - 7 (High)",
  colour = "Sex",
  shape = "Subject"
)

# m3
# Plot mean results of mastery approach questions
# for all students with relation to student's year, sex and subject
# data
d <- ggplot(data = dat, aes(year, mean_dat$m3))
# mapping data (use "jitter" to improve the graph and avoid gridding)
l <- d + geom_jitter(aes(colour = sex, shape = subject))
# smoothing
s <- l + geom_smooth(method = stats::loess, formula = y ~ log(x), se = TRUE)
# adding theme
t <- s + theme_dark()
# adding colouring
c <- t + scale_colour_brewer(palette = "Pastel1")
# adding labels
c + labs(
  title = "Student's focus on understanding set on basis of:
different years of study, sexes and subjects.",
  subtitle = "Prevalence of mastery approach.",
  caption = "Data source: Elliot, A. J. and McGregor, H. A. (2001)",
  x = "Year: 1 - 4",
  y = "Answer: 1 (Low) - 7 (High)",
  colour = "Sex",
  shape = "Subject"
)

# m4
# Plot mean results of mastery avoidance questions
# for all students with relation to student's year, sex and subject
# data
d <- ggplot(data = dat, aes(year, mean_dat$m4))
# mapping data (use "jitter" to improve the graph and avoid gridding)
l <- d + geom_jitter(aes(colour = sex, shape = subject))
# smoothing
s <- l + geom_smooth(method = stats::loess, formula = y ~ log(x), se = TRUE)
# adding theme
t <- s + theme_dark()
# adding colouring
c <- t + scale_colour_brewer(palette = "Pastel1")
# adding labels
c + labs(
  title = "Student's focus on understanding set on basis of:
different years of study, sexes and subjects.",
  subtitle = "Student's fear of not mastering the course.",
  caption = "Data source: Elliot, A. J. and McGregor, H. A. (2001)",
  x = "Year: 1 - 4",
  y = "Answer: 1 (Low) - 7 (High)",
  colour = "Sex",
  shape = "Subject"
)

# interest
# Plot mean results of course interestedness expectations questions
# for all students with relation to student's year, sex and subject
# data
d <- ggplot(data = dat, aes(year, mean_dat$m_interest))
# mapping data (use "jitter" to improve the graph and avoid gridding)
l <- d + geom_jitter(aes(colour = sex, shape = subject))
# smoothing
s <- l + geom_smooth(method = stats::loess, formula = y ~ log(x), se = TRUE)
# adding theme
t <- s + theme_dark()
# adding colouring
c <- t + scale_colour_brewer(palette = "Pastel1")
# adding labels
c + labs(
  title = "Student's course interestedness expectations set on basis of:
different years of study, sexes and subjects.",
  subtitle = "\'I expect my courses this semester to be very interesting\'",
  caption = "Data source: Elliot, A. J. and McGregor, H. A. (2001)",
  x = "Year (1-4)",
  y = "Expectations: 1 (Low) - 7 (High)",
  colour = "Sex",
  shape = "Subject"
)

ggplotly(c + labs(
  title = "Student's course interestedness expectations set on basis of:
different years of study, sexes and subjects.",
  subtitle = "\'I expect my courses this semester to be very interesting\'",
  caption = "Data source: Elliot, A. J. and McGregor, H. A. (2001)",
  x = "Year (1-4)",
  y = "Expectations: 1 (Low) - 7 (High)",
  colour = "Sex",
  shape = "Subject"
))

# chi-squared
chi_sqrt <- ggplot(data = dat, aes(year, mean_dat$m_interest)) +
  stat_function(fun = dchisq, args = list(df = 8))
chi_sqrt

# enjoy
# Plot mean results of course enjoyment expectations questions 
# for all students with relation to student's year, sex and subject
# data
d <- ggplot(data = dat, aes(year, mean_dat$m_enjoy))
# mapping data (use "jitter" to improve the graph and avoid gridding)
l <- d + geom_jitter(aes(colour = sex, shape = subject))
# smoothing
s <- l + geom_smooth(method = stats::loess, formula = y ~ log(x), se = TRUE)
# adding theme
t <- s + theme_dark()
# adding colouring
c <- t + scale_colour_brewer(palette = "Pastel1")
# adding labels
c + labs(
  title = "Student's course enjoyment expectations set on basis of:
different years of study, sexes and subjects.",
  subtitle = "\'I expect my courses this semester to be very enjoyable\'",
  caption = "Data source: Elliot, A. J. and McGregor, H. A. (2001)",
  x = "Year (1-4)",
  y = "Expectations: 1 (Low) - 7 (High)",
  colour = "Sex",
  shape = "Subject"
)

# mastgrad
# Plot mean results of (Primarly understanding/Equal Importance/Primarly grades)scale 
# for all students with relation to student's year, sex and subject
# data
d <- ggplot(data = dat, aes(year, mean_dat$m_mastgrad))
# mapping data (use "jitter" to improve the graph and avoid gridding)
l <- d + geom_jitter(aes(colour = sex, shape = subject))
# smoothing
s <- l + geom_smooth(method = stats::loess, formula = y ~ log(x), se = TRUE)
# adding theme
t <- s + theme_dark()
# adding colouring
c <- t + scale_colour_brewer(palette = "Pastel1")
# adding labels
c + labs(
  title = "Student's importance scale between understanding and grades set on basis of:
different years of study, sexes and subjects.",
  subtitle = "Scale: Primarly understanding (1) / Equal Importance (4) / Primarly grades (7)",
  caption = "Data source: Elliot, A. J. and McGregor, H. A. (2001)",
  x = "Year (1-4)",
  y = "Scale: 1 (Understanding) - 4 (Equal) - 7 (Grades)",
  colour = "Sex",
  shape = "Subject"
)

