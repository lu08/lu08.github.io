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
mydata.string <- "1111010101000011"
mydata <- strsplit(mydata.string,'') %>% unlist() %>% as.numeric()
f.B10(mydata)
