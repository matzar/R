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

# making an example table
createExampleTable <- function(table) {
  # get first 6 columns and random 4 rows
  temp1 <- table[6:9,1:6]
  # add spacing
  temp1$... <- c("...", "...", "...", "...")
  # get remaining columns and rows
  temp2 <- table[6:9,16:19]
  # combine
  temp3 <- dplyr::bind_cols(temp1, temp2)
  
  return(temp3)
}

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
  )
# Adding proper labeling
labeled_data <- renamed_data %>%
  rename(
    IR = interest,
    EJ = enjoy,
    MG = mastgrad
  )

# save renamed and labeled table in 'dat' variable
dat <- labeled_data
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
# get mean from Q1, Q2, Q3 columns (Performance approach questions) for all the students
# save the results in 'M1' colum and add it to 'mean_dat' table
mean_dat <- mean_dat %>% 
  mutate(M1 = pmap_dbl(select(., c("Q1", "Q2", "Q3")), function(...) mean(c(...))))

# get mean from Q4, Q5, Q6 columns (Performance avoidance questions) for all the students,
# save the results in 'M2' colum and add it to 'mean_dat' table
mean_dat <- mean_dat %>% 
  mutate(M2 = pmap_dbl(select(., c("Q4", "Q5", "Q6")), function(...) mean(c(...))))

# get mean from Q7, Q8, Q9 columns (Mastery approach questions) for all the students
# save the results in 'M3' colum and add it to 'mean_dat' table
mean_dat <- mean_dat %>% 
  mutate(M3 = pmap_dbl(select(., c("Q7", "Q8", "Q9")), function(...) mean(c(...))))

# get mean from Q10, Q11, Q12 columns (Mastery avoidance questions) for all the students 
# save the results in 'M4' colum and add it to 'mean_dat' table
mean_dat <- mean_dat %>% 
  mutate(M4 = pmap_dbl(select(., c("Q10", "Q11", "Q12")), function(...) mean(c(...))))

# save final cleaned table
write_csv(mean_dat, "data/MeanCleanedStudentGoals.csv")
# save final cleaned table as tibble table
dat_tibble <- as_tibble(mean_dat)

## CLASSIFICATION ###################################################
# dat_tibble %>%
#   head() %>%
#   knitr::kable()

# Find a student who is not enjoying the course, finds it not interesting but still primarly aims to perform better than others and is lead by the fear of performing poorly
dat_tibble_enjoy <- filter(dat_tibble, EJ <= 2)
dat_tibble_interest <- filter(dat_tibble_enjoy, IR <= 2)
dat_tibble_mastgrad <- filter(dat_tibble_interest, M1 >= 6)
mm1 <- filter(dat_tibble_mastgrad, M1 >= 6)
mm2 <- filter(mm1, M2 >= 6)

n_mm2 <- tally(mm2)

p_hat <- n_mm2 / n
z_score <- 1.96

ci_up <- p_hat + 1.96 * sqrt((p_hat * (1 - p_hat)) / (n))
ci_low <- p_hat - 1.96 * sqrt((p_hat * (1 - p_hat)) / (n))
#####################################################################