library(Lock5Data)
library(tidyverse)
NBAPlayers2024$pointsPerGame <- NBAPlayers2024$Points/NBAPlayers2024$Games

?NBAPlayers2024
str(NBAPlayers2024)

#------------------------------#
# in class code: 9/24
#------------------------------#

summary(NBAPlayers2024$Age)
quantile(NBAPlayers2024$Age, c(0.05,0.10,0.95))



summary(NBAPlayers2024$FGPct)
hist(NBAPlayers2024$FGPct)


NBAPlayers2024 %>% 
  filter(Team %in% c("NYK","BRK"))%>%
  arrange(desc(FGPct)) %>%
  select(Player, Pos, Team, FGPct, Games) %>%
  slice(1:20)

NBAPlayers2024$Team %>% unique()

NBAPlayers2024 %>%
  group_by(Team)%>%
  summarise(mean = mean(FGPct), med = median(FGPct), 
            IQR = IQR(FGPct), age = mean(Age)) %>%
  arrange(desc(age))
