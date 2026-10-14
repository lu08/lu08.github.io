#-------------------------------------------#
# target function
#-------------------------------------------#
# f(x) = 6*x*(1-x) if x is between 0 and 1
# f(x) = 0 otherwise
target <- function(x){
  result <- 6*x*(1-x)
  result[x<0 | x>1] <- 0
  return(result)
}

# visualize the target function
curve(target(x),col='red') 

# note: the target is actually beta(2,2) density
curve(dbeta(x,shape1=2,shape2=2),add=T,col='blue',lwd=2,lty='dashed')


#-------------------------------------------#
# sampling using acceptance-rejection
#-------------------------------------------#

####### proposal: unif(0,1)

nsim <- 10000
result <- numeric()
C <- 10

# run algorithm
for(i in 1:nsim){
  prop <- runif(1)
  u <- runif(1)
  acc.rate <- target(prop)/(C*dunif(prop))
  if( u < acc.rate){
    result <- c(result,prop)
  }
}

# verify result
mean(result) #should be close to 0.5

hist(result,nclass=20,prob=T)
curve(target(x),add=T,col='red',lwd=2)  #histogram should be close to target

length(result)/nsim #acceptance rate, close to 1/C



#-------------------------------------------#
# sampling using SIR with uniform importance function
#-------------------------------------------#
nsim.target <- 10000
nsim.initial <- nsim.target*10

# draw candidates
candidates <- runif(nsim.initial)

# calculate weights
weights <- target(candidates)/dunif(candidates)
# weights/sum(weights) # can standardize the weights

# resample
result <- sample(candidates,size=nsim.target,replace=T,prob=weights)

# verify results
mean(result) #should be close to 0.5
hist(result,nclass=20,probability=T)
curve(target(x),add=T,col='red',lwd=2)



#-------------------------------------------#
# sampling using SIR with normal importance function
#-------------------------------------------#
nsim.target <- 10000
nsim.initial <- nsim.target*10

# specify normal parameters
prop.mean <- 0.5
prop.sd <- 0.3

# compare target with the importance function
curve(target(x),col='red') 
curve(dnorm(x,mean=prop.mean,sd=prop.sd),col='blue',add=T,lty='dashed')


# draw candidates
candidates <- rnorm(nsim.initial,mean=prop.mean,sd=prop.sd)
weights <- target(candidates)/dnorm(candidates,mean=prop.mean,sd=prop.sd)

# resample
result <- sample(candidates,size=nsim.target,replace=T,prob=weights)

# verify results
mean(result) #should be close to 0.5
hist(result,nclass=20,probability=T)
curve(target(x),add=T,col='red',lwd=2)







