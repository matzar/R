library(tidyverse)
library(modelr)
library(rsample)
library(broom)
library(magrittr)

set.seed(1234)

theme_set(theme_minimal())

library(ISLR)

Auto <- as_tibble(Auto)
Auto

