library(tidyverse)
library(Lock5Data)

# print and cat
i <- 1; i
NBAPlayers2024$Player[1]

for(i in 10:15){
  print(NBAPlayers2024$Player[1])
}


for(i in 10:15){
  cat(NBAPlayers2024$Player[1])
}


for(i in 10:15){
  cat(paste(i, "Name", NBAPlayers2024$Player[i]))
}

animal <- c('cat','dog')
id <- c(1:5)
cat(animal, id)

for(a in 1:10){
  print(a)
}




# (a)
for(i in c(5:10)){
  print(i)
}

# (b)
a <- 10
for(k in c(1,2,3)){
  print(k+a)
}

# (c)
v <- c(10,30,50,10,30,50,10,30,50)
for(i in c(3,6,9)){
  print(v[i])
}


for(a in c(4,7,6)){
  print(a+2)
}


for(num in seq(0,10,by=2)){
  print(paste('value of number is', num))
}


for(index in c(1:10)){
  #index <- 1
  print(paste0(index,"+",index,"=",index+index))
}


for(i in 1:10){
  # do something
}


result <- rep(NA, 1000)

for(i in 1:1000){
  result[i] <- play.game()
}


sample(x=c(1:6),size=1)

# initialize
result <- rep(NA, 10)
for(i in 1:10){
  result[i] <- sample(x=c(1:6),size=1)
}















