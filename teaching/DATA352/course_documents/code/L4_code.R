#-------------------------------------------#
# Density estimation demo
#-------------------------------------------#
sleephour=c(4, 4.5,  5, 5, 8, 5, 7,
            6, 6, 7.5, 8, 6, 4, 
            7, 7, 4, 6, 7, 7, 3, 8, 
            8, 3, 6, 5, 5.5, 3, 6, 8, 7,
            6.7, 7.75, 9, 8, 5, 8, 6, 7)

#hist(sleephour,nclass = 10)


hist(sleephour,
     xlab='Hours',
     main='Hours of sleep',
     probability=T, 
     col='royalblue',
     ylab=NA,
     nclass =5)



#larger bandwidth (bw) = smoother fitting
#choice of bandwidth also depends of the scale of data
dest <- density(sleephour,kernel="gaussian",bw=0.5)
lines(dest,col="red",lwd=2)


dunif(4, min=0, max=3)
2.3/3
punif(2.3, min=0, max=3)


waitingtime <- rexp(1000,rate=1/10)
hist(waitingtime)





birthmonth <- c(8, 3, 4, 11, 1, 10, 11, 11, 5, 2, 11)
mean(birthmonth)


exam_score <- runif(25, min=0, max=100)
hist(exam_score,nclass = 10)
mean(exam_score)

avg <-  c(55.2, 48.9, 49.2, 51.7, 58, 50.3, 49.7, 49.2, 50.05, 51.08)
hist(avg, nclass=10)

# simulate 10000 times to obtain 10000 averages
nsim <- 10000
result <- rep(NA, nsim)

for(i in 1:nsim){
  exam_score <- rbeta(30, shape1 = 10, shape2 = 1)
  result[i] <- mean(exam_score)
}
hist(result)
mean(result)
sd(result)
range(result)
