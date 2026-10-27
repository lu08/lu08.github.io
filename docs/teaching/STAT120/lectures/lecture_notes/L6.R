library(tidyverse)
library(plotly) # for interactive plot
library(maps) # for map example
library(kableExtra) # for formatting in presentation; optional


table4a

table4a %>% 
  pivot_longer(cols = 2:3, names_to = "YRS", values_to = "caseNum")


table4b
pivot_longer(table4b, 
             cols = 2:3, 
             names_to = "year", 
             values_to = "population")


df.score <- data.frame(student = c('A','B','C'),
                       math = c(99,73,12),
                       literature = c(45,78,96),
                       PE = c(56, 55, 57))
df.score

df.score.long <- df.score %>%
  pivot_longer(cols = 2:4, names_to = "subject", values_to = "score")
df.score.long

# these code are equivalent 
df.score %>% pivot_longer(cols = 2:4, names_to = "subject", values_to = "score")
df.score %>% pivot_longer(cols = c(math,literature,PE), names_to = "subject", values_to = "score")
df.score %>% pivot_longer(cols = math:PE, names_to = "subject", values_to = "score")
df.score %>% pivot_longer(cols = -student, names_to = "subject", values_to = "score")



par(mfrow=c(1,2))
boxplot(df.score.long$score ~ df.score.long$student, xlab='students', ylab='scores') 
boxplot(df.score.long$score ~ df.score.long$subject, xlab='subjects', ylab='scores') 





df.run <- read.csv('../../../../dataset/running.csv')

# On average, which day of the week do I tend to run the most?

mean(df.run$Mon)
mean(df.run$Sun)
summary(df.run)

# Top 5 days where I run the most miles?

df.run.long <- 
  df.run %>% pivot_longer(cols = Mon:Sun, 
                           names_to = "Day_of_week",
                           values_to = "Miles")

df.run.long %>%
  arrange(desc(Miles)) %>%
  slice(1:5)




