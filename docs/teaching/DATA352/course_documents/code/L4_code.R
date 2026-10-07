#-------------------------------------------#
# Density estimation demo
#-------------------------------------------#
sleephour=c(4, 4.5,  5, 5, 8, 5, 7,
            6, 6, 7.5, 8, 6, 4, 
            7, 7, 4, 6, 7, 7, 3, 8, 
            8, 3, 6, 5, 5.5, 3, 6, 8, 7)

hist(sleephour)

hist(mtcars$hp)



hist(sleephour,
     xlab='Hours',
     main='Hours of sleep',
     probability=T, 
     col='royalblue',
     ylab=NA,
     nclass =10)



#larger bandwidth (bw) = smoother fitting
#choice of bandwidth also depends of the scale of data
dest = density(sleephour,kernel="gaussian",bw=0.2)
lines(dest,col="red",lwd=2)


