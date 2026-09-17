#-------- Load data and packages -------#
library(tidyverse)
#getwd()
#setwd("Google Drive/My Drive/Class/2026FA_STAT120/")
df.building <- read.csv("../../Dataset and resource/tallest building/tallest building_2026.csv")


#-------- clean data -------#
df.building$Height_f

df.building$Height_f <- 
  as.numeric(gsub(pattern = ',', replacement = '', df.building$Height_f))

# Equivalent code with pipe operator
df.building$Height_f <- df.building$Height_f %>% 
  gsub(pattern = ',', replacement = '') %>%
  as.numeric()

df.building <- df.building %>%
  mutate(
    Floors_num = str_extract(Floors, "^\\d+") %>% 
      as.integer(),
    Floors_additional = str_extract(Floors, "(?<=\\(\\+ )\\d+") %>% 
      as.integer(),
    Floors_additional_text = str_extract(Floors, "(?<=\\d )[^(]+(?=\\))") %>% 
      str_trim()
  )

# double check
str(df.building)



#-------- create new variables -------#
df.building$Location_F <- as.factor(df.building$Location)



#-------- in class code -------#
df.building %>%
  mutate(Location_F = as.factor(Location)) %>%
  group_by(Location_F) %>%
  summarise(median_year = median(Year), 
            mean_height = mean(Height_m),
            max_height = max(Height_m),
            count = length(Year)) %>%
  arrange(desc(max_height))


par(mfrow=c(1,2))
plot(df.building$Location_F) #bar graph
plot(df.building$Location_F,df.building$Height_m)  #boxplots by Location

class(df.building)
df.building[c(1,2,3),2]
df.building[c(1,2,3)] # columns 1, 2, 3
df.building$Name[c(1:5)]




names(df.building) # variable names
dim(df.building) # dimension (row, column)
nrow(df.building) # number of rows
str(df.building) # summary information
head(df.building) # first few rows
tail(df.building) # last few rows


df.building$Name[1:5]
df.building$Height_m[1:5] %>% mean()

df.building$ft.per.floor <- df.building$Height_f/df.building$Floors_num

tapply(df.building$ft.per.floor, df.building$Location_F, mean)

df.building %>% 
  group_by(Location_F) %>% 
  summarise(mean(ft.per.floor))

plot(df.building$Year, df.building$Height_f, col=df.building$Location_F)





