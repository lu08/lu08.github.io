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



#------------------------------#
# in class code: 9/15
#------------------------------#
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



#------------------------------#
# in class code: 9/17
#------------------------------#
sample.size <- nrow(df.building)
variables <- names(df.building)


list.building <- list(D=df.building,
                      sample.size = sample.size,
                      variables = variables)
list.building[[3]]




# these code are equivalent
plot(df.building$Height_m,df.building$Floors_num,xlab='Height')


df.building$Height_m %>% 
  plot(x=., y=df.building$Floors_num,xlab='Height')


df.building$Floors_num %>%
  plot(x=df.building$Height_m, y=., xlab="Height")





df.building$Height_m %>% 
  plot(df.building$Floors_num,xlab='Height')

df.building$Height_m %>% 
  plot(x=., y=df.building$Floors_num,xlab='Height')

df.building$Height_m |>
  plot(x=_, y=df.building$Floors_num,xlab='Height') 



mycol <- rep(NA, nrow(df.building))

mycol[which(df.building$Year <= 2009)] <- "red"
mycol[which( df.building$Year <= 2015 & df.building$Year >= 2010)] <- "blue"
mycol[df.building$Year>=2016] <- "green"

plot(df.building$Height_m, df.building$Floors_num, 
     col = mycol, pch=16,
     xlab = "Height in meters",
     ylab = "Num of floor",
     main = "my scatterplot")


#------------------------------#
# in class code: 9/22
#------------------------------#

# names of buildings in the United States AND also built after 2015

df.building %>%
  filter(Location == "United States",Year>2015) %>%
  select(Name)

df.building[df.building$Location=="United States" & df.building$Year>2015, ]

df.building$Name[df.building$Location=="United States" & df.building$Year>2015]

df.building$Name[which(df.building$Location=="United States" & df.building$Year>2015)]


