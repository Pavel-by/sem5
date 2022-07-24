#a
x = c(0.589, 0.596, 0.215, 0.664, 0.323, 0.005, 2.487, 0.662, 0.584,
  0.031, 1.136, 1.494, 2.698, 1.516, 0.839, 0.186, 2.173, 1.014, 0.198,
  0.344, 2.269, 0.209, 1.609, 0.803, 0.228, 1.382, 1.763, 0.413, 2.474,
  0.034, 3.198, 3.552, 0.165, 0.570, 0.484, 1.558, 1.381, 0.117, 0.034,
  0.536, 2.455, 1.765, 0.973, 0.044, 3.889, 0.327, 0.013, 0.394, 0.141,
  0.354)
vararr <- sort(x)
F <- function(x, t) {
  z <- x[x<t]
  return(length(z) / length(x))
}

plot(ecdf(x))
hist(x, breaks = c(min(x):max(x)), right = TRUE)

#b
meanX <- sum(x) / length(x)
variance <- sum(x^2) / length(x) - meanX^2
if (length(x) %% 2 != 0) {
  median <- vararr[(length(vararr) - 1) / 2]
} else {
  median <- (vararr[length(vararr) / 2] + vararr[length(vararr) / 2 + 1]) / 2
}
assym <- sum((x - meanX)^3) / (length(x) * variance^(3/2))
excess <- (sum((x - meanX)^4) / (length(x) * variance^2)) - 3
Px <- function (a, b) {
  return(F(x, b) - F(x, a))
}

#c
library("maxLik")
LL<-function(t){sum(dpois(x,t[1],log=TRUE))}
maxLL<-maxNR(LL,start=c(1))
OMP<-maxLL$estimate
mean<-sum(x)/length(x)

#d
TI <- function(a1) {
  mean<-sum(x)/length(x)
  xa<-qnorm (1-a1/2)
  return(c(
    mean-xa*sqrt(mean/length(x)),
    mean+xa*sqrt(mean/length(x)) 
  ))
}

#e
r<-5
Xi2<-19.1537
maxval <- pchisq(Xi2,r-2,lower.tail = FALSE);

#g
lambda<-1.4
a1<-0.1
c<-0
a0<-ppois(c,lambda*length(x))
while (a0<a1) 
{
  c<-c+1;
  a0<-ppois(c,lambda*length(x))
}
c<-c-1
#print(c)
p<-(a1-ppois(c,lambda*length(x)))/dpois(c,lambda*length(x))
#print(p)
#print(a0)

#fd
TIf <- function(a1) {
  mean<-sum(x)/length(x)
  xa<-qnorm (1-a1/2)
  return(c(
    mean-xa*sqrt((mean*(mean+1))/length(x)),
    mean+xa*sqrt((mean*(mean+1))/length(x))  
  ))
}

#fe

r<-5
Xi2<-6.179853
maxval <- pchisq(Xi2,r-2,lower.tail = FALSE)
print(maxval)
