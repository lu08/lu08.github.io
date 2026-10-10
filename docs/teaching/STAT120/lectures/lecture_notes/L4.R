library(tidyverse)
library(Lock5Data)


#------------------------------#
# in class code: 10/06
#------------------------------#

vect <- c(3.4, 3.5, 4, 2.2)
sort(vect,decreasing = T)
order(vect,decreasing = T)

# Review questions

length(unique(HollywoodMovies$Genre))
table(HollywoodMovies$Genre)

diff <- abs(HollywoodMovies$RottenTomatoes - HollywoodMovies$AudienceScore)
sort(diff,decreasing = T)
HollywoodMovies$Movie[order(diff,decreasing = T)[1:10]]

mean(HollywoodMovies$AudienceScore[HollywoodMovies$Genre == "Action"],
     na.rm = T)
mean(HollywoodMovies$AudienceScore[HollywoodMovies$Genre == "Adventure"],
     na.rm = T)

tapply(HollywoodMovies$AudienceScore, 
       HollywoodMovies$Genre,
       mean,  na.rm=T)


index <- order(HollywoodMovies$WorldwideBO[HollywoodMovies$Genre=="Action"],
      decreasing = T)

HollywoodMovies$Movie[HollywoodMovies$Genre=="Action"][index[1:5]]




max(HollywoodMovies$WorldwideBO[HollywoodMovies$Genre == "Action"],
     na.rm = T)
which.max(HollywoodMovies$WorldwideBO[HollywoodMovies$Genre == "Action"])

tapply(HollywoodMovies$WorldwideBO, 
       HollywoodMovies$Genre,
       which.max)


HollywoodMovies$Movie[c(5,10)]
'['(HollywoodMovies$Movie, c(5,10))

HollywoodMovies$Movie %>% '['(c(5,10))

?filter()


vec <- c(1,2,3)
mean(vec)
vec |> mean()


?HollywoodMovies
HollywoodMovies |>
  filter(Year == 2023) |>
  arrange(desc(WorldwideBO)) |>
  slice(1:10) |>
  select(Movie, Genre, WorldwideBO, Year)

