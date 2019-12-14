library(titanic)
library(tidyverse)
library(ggdistribute)

library(ggplot2)
library(tidyr)
library(tibble)
library(hrbrthemes)
library(dplyr)

view(Titanic)

n <- tally(titanic_data)
pc1 <- filter(titanic_data, Pclass == 1)
spc1 <- filter(titanic_data, Pclass == 1 & Survived == 1)

prob_of_survival_pc1 <- (tally(spc1) / n) * 100

d <- ggplot(titanic_data, aes(Pclass, Survived)) + scale_color_continuous()
d + geom_hex()

ggplot(titanic_data, aes(Survived, Pclass, colour = Age, shape = Sex))  + scale_color_viridis_c() +
  geom_jitter()
