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


#------------------------------#
# in class code: 9/29
#------------------------------#

# by hand: a vector is created
a <- NBAPlayers2024$FGPct
z1 <- (a - mean(a))/sd(a)

# using scale(): a matrix is created
z2 <- scale(NBAPlayers2024$FGPct)

# store z-score of FGPct
NBAPlayers2024$FGPct_zscore <- (NBAPlayers2024$FGPct - mean(NBAPlayers2024$FGPct))/sd(NBAPlayers2024$FGPct)

# tidyverse version
NBAPlayers2024 %>% 
  mutate(FGPct_zscore = scale(FGPct)) %>%
  arrange(desc(FGPct_zscore)) %>%
  slice(1:5) %>%
  dplyr::select(Player, Pos, Team, FGPct, FGPct_zscore)


summary(NBAPlayers2024$FG3Pct)
scale(NBAPlayers2024$FG3Pct)




NBAPlayers2024 %>% 
  mutate(FGPct_zscore = scale(FGPct), FG3Pct_zscore = scale(FG3Pct) ) %>%
  filter(Player == "Stephen Curry") %>%
  #arrange(desc(FGPct_zscore)) %>%
  #slice(1:5) %>%
  dplyr::select(Player, Pos, Team, FGPct, FG3Pct, FGPct_zscore,FG3Pct_zscore)




NBAPlayers2024 %>% 
  mutate(FGPct_zscore = scale(FGPct), FG3Pct_zscore = scale(FG3Pct) ) %>%
  filter(FGPct_zscore > 1, FG3Pct_zscore > 1) %>%
  #arrange(desc(FGPct_zscore)) %>%
  #slice(1:5) %>%
  dplyr::select(Player, Pos, Team, FGPct, FG3Pct, FGPct_zscore,FG3Pct_zscore)


NBAPlayers2024 <- 0
rm(NBAPlayers2024)

myvec <- c(1,2,3)
myvec[0]