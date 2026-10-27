ncov_simple <- read.csv("../L6_Incubation Models/nCoV_simple.csv")

ncov_simple <- read.csv(file.choose())


#install.packages("MASS")
library("MASS")

?fitdistr()

result <- fitdistr(ncov_simple$incubation,'normal')
result$estimate
result$sd
result$loglik

# "Hand calculation" of the log likelihood
log(prod(dnorm(ncov_simple$incubation,mean=4.1076,sd=2.3166)))



par(mfrow=c(1,2))
hist(ncov_simple$incubation,main='normal, mean=4.11, SD=2.32 \n loglikelihood = -112.95',
     col='lightblue',freq = F,
     xlab=NA,nclass=10)
curve(dnorm(x,mean=4.1076,sd=2.3166),
      add=T,col='red',lwd=2,lty='dashed')
hist(ncov_simple$incubation,main='normal, mean=8, SD=1.8 \n loglikelihood = -233.65',
     col='lightblue',freq = F,
     xlab=NA,nclass=10)
curve(dnorm(x,mean=8,sd=1.8),
      add=T,col='red',lwd=2,lty='dashed')





plnorm(14,meanlog = 1.209, sdlog=0.731)
1-plnorm(5,meanlog = 1.209, sdlog=0.731)
rlnorm(1000,meanlog = 1.209, sdlog=0.731)





