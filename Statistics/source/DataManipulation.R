# load libraries
library(tidyverse)
library(modelr)
library(rsample)
library(broom)
library(magrittr)
library(ggsci)

# set seed for randomization to ensure that results are always reproduced precisely
set.seed(1234)

# read csv file (worse variable recognition)
f <- "data/StudentGoalsData.csv"
StudentGoalsOriginal <- read_csv(f, col_types = cols(), skip_empty_rows = TRUE)

# drop 'seq' column since it doesn't serve any purpose
StudentGoalsData <- StudentGoalsOriginal  %>%  ungroup  %>%  select(-seq)

# count all the students before cleaning and dropping the data
n <- tally(StudentGoalsData)

# # clean data - drop results contaiting empty cells
CleanedStudentGoalsData <- drop_na(StudentGoalsData)

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
    Q4 = q12,
    ir = interest,
    ej = enjoy,
    mg = mastgrad
  )
# going back to lower case 'q' to keep naming consistent with the original data set
renamed_data2 <- renamed_data %>%
  rename(
    q1 = Q1, q2 = Q2, q3 = Q3, q4 = Q4, q5 = Q5, q6 = Q6, 
    q7 = Q7, q8 = Q8, q9 = Q9, q10 = Q10, q11= Q11, q12 = Q12
  )
# save renamed table in 'dat' variable
dat <- renamed_data2
# summary(dat)
# plot(dat) # r function for plotting
# dat[1:4, 1:4]

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

## MEAN CALCULATION FOR 7 CATEGORIES: ###################################################
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

# Find a student who is not enjoying the course, finds it not interesting but still primarly aims to perform better than others and is lead by the fear of performing poorly
dat_tibble_enjoy <- filter(dat_tibble, ej <= 2)
dat_tibble_interest <- filter(dat_tibble_enjoy, ir <= 2)
dat_tibble_mastgrad <- filter(dat_tibble_interest, m1 >= 6)
mm1 <- filter(dat_tibble_mastgrad, m1 >= 6)
mm2 <- filter(mm1, m2 >= 6)

n_mm2 <- tally(mm2)

p_hat <- n_mm2 / n
z_score <- 1.96

ci_up <- p_hat + 1.96 * sqrt((p_hat * (1 - p_hat)) / (n))
ci_low <- p_hat - 1.96 * sqrt((p_hat * (1 - p_hat)) / (n))
#####################################################################