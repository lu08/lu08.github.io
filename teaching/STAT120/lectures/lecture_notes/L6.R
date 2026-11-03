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




# -------- #
# in class code: 10/29
# maps
# -------- #

library(maps)
library(tidyverse)

?map_data()

mymap <- map_data(map="state")
head(mymap)
plot(mymap$long,mymap$lat)


mymap %>% ggplot(aes(x=long, y=lat, group=group)) +
  geom_polygon() +
  theme_void() +
  coord_fixed(1.4)

USArrests$state <- row.names(USArrests) %>% tolower()
mymap <- map_data(map="state")

# Combine crime data to map data
mymap <- left_join(mymap, USArrests, by=c('region'='state'))

# Visualize
mymap %>%
  ggplot(aes(x=long,y=lat,group=group, fill=Murder)) +
  geom_polygon(color='darkblue') +
  coord_fixed(1.4) +
  theme_void() +
  labs(fill='Murder rate') +
  scale_fill_gradient(low="lightblue", high="darkred")







# NJ map
mymap <- map_data(map="county")
head(mymap)
mymap$region %>% unique()
mymap <- mymap %>% filter(region == "new jersey")

mymap %>% ggplot(aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="pink", color="black") +
  theme_void() +
  coord_fixed(1.4)

# NJ data
df.nj <- read.csv("Google Drive/My Drive/Dataset and resource/NJcounty/NJ_county.csv")

head(mymap)
head(df.nj)

# converting county names to lower case
df.nj$County <- tolower(df.nj$County)

# combine data
mymap.nj <- left_join(mymap,  df.nj, by=c("subregion" = "County"))
mymap.nj %>% head()

p <- mymap.nj %>% 
  ggplot(aes(x=long, y=lat, group=group,fill=Median_household, text=subregion)) +
  geom_polygon(color="black") +
  theme_void() +
  coord_fixed(1.4) +
  scale_fill_gradient(low="yellow",high="blue")+
  labs(fill="Income")

library(plotly)
ggplotly(p)


df.student <- 
  data.frame(name=c('A','B','C','D'),
             exam=c(80,91,85,78),
             project=c(1,2,1,NA))

df.project <-
  data.frame(projectID = c(1:3),
             description = c('visualization','classification','text mining'))

inner_join(df.student, df.project, by=c('project' = 'projectID'))

left_join(df.student, df.project, by=c('project' = 'projectID'))

left_join(df.project, df.student, by=c('projectID' = 'project'))

right_join(df.student, df.project, by=c('project' = 'projectID'))

full_join(df.student, df.project, by=c('project' = 'projectID'))












