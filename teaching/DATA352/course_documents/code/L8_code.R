#----------------------------------------------------------------------------#
#  M = integer
#  returns log(factorial(M))
#----------------------------------------------------------------------------#
f.logfac <- function(M){
  result <- ifelse(M==0,0,sum(log(c(1:M))))
  return(result)
}

#----------------------------------------------------------------------------#
# calculate (**) = [data | M1= 1-cut-point-model, C=c] for a specific cut point c
#  x = data vector, each value is 0 or 1
#  c = integer between 1 to length(x)-1
#  returns a numeric value 
#----------------------------------------------------------------------------#
f.likelihoodM1 <- function(x,c=1){
  if(length(x)==1){
    return(0)
  }else{
    result <- f.logfac(sum(x[1:c])) + f.logfac(c-sum(x[1:c])) + 
      f.logfac(sum(x[(c+1):length(x)])) + 
      f.logfac(length(x)-c-sum(x[(c+1):length(x)])) -
      f.logfac((c+1)) - 
      f.logfac(length(x)-c+1)
    
    return(exp(result))
  }
}

#----------------------------------------------------------------------------#
# calculate Bayes factor (B10)
#  x = data vector, each value is 0 or 1
#  returns a numeric value 
#----------------------------------------------------------------------------#
f.B10 <- function(x){
  if(length(x)==1){
    return(0)
  }else{
    LC <- rep(NA,(length(x)-1))
    for(c in 1:length(LC)){
      LC[c] <- f.likelihoodM1(x,c)
    }
    
    LM1 <- mean(LC)
    LM0 <- exp(f.logfac(sum(x)) + f.logfac(length(x)-sum(x)) - f.logfac(length(x)+1))
    return(LM1/LM0)
  }
}


#----------------------------------------------------------------------------#
# estimate break point C
# x = data vector, each value is 0 or 1
# returns a numeric value 
#----------------------------------------------------------------------------#
f.c <- function(x){
  LC <- rep(NA,(length(x)-1))
  for(c in 1:length(LC)){
    LC[c] <- f.likelihoodM1(x,c)
  }
  
  return(sum(LC*c(1:length(LC)))/sum(LC))
}


library(dplyr)

# data representing Phoenix Sun's win/lose record

mydata.string <- "0100001101"
mydata <- strsplit(mydata.string,'') %>% unlist() %>% as.numeric()
f.B10(mydata)


result <- rep(NA, 1000)

for(i in 1:1000){
  newdata <- sample(c(0,1),
                    size=length(mydata),
                    replace=T,
                    prob = c(mean(mydata==0), mean(mydata==1)))
  
  result[i] <- f.B10(newdata)
}

result
hist(result,nclass = 50, main="B10 value with NO streak")

# empirical p-value
(sum(result>f.B10(mydata)) + 1)/(1000 + 1)






tea <- c('T','T','T','T','M','M','M','M')
choice <- sample(tea,size=4,replace=F); choice

nsim<-10000
result <- rep(NA,nsim)
for(i in 1:nsim){
  choice<-sample(tea,size=4,replace=F)
  result[i]<-sum(choice=='T')
}
table(result)/10000

# 4 out of 4
(142 + 1) / (10000 + 1)
# p-value is 0.014
# conclusion: reject null; she can tell the difference

# 3 out of 4
(2251 +142+ 1)/(10000+1)
# p-value is 0.24
# conclusion: fail to reject null; she might be guessing






