# 1) During students’ junior years, they tend to primarily focus on getting good grades while during their senior years, the focus shifts towards a deep-understanding of the subject and. 

# Plot set on basis of the student's sex.
# Plot mean results of (Primarly understanding/Equal Importance/Primarly grades)scale 
# for all students with relation to student's year, sex and subject
# data
d <- ggplot(data = dat, aes(year, mean_dat$mastgrad))
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

# Plot set on basis of the student's subject.
# Plot mean results of (Primarly understanding/Equal Importance/Primarly grades)scale 
# for all students with relation to student's year, sex and subject
# data
d <- ggplot(data = dat, aes(year, mean_dat$mastgrad))
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