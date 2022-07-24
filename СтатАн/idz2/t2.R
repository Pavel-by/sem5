x = c(0.589, 0.596, 0.215, 0.664, 0.323, 0.005, 2.487, 0.662, 0.584, 0.031, 1.136, 1.494, 2.698, 1.516, 0.839, 0.186, 2.173, 1.014, 0.198, 0.344, 2.269, 0.209, 1.609, 0.803, 0.228, 1.382, 1.763, 0.413, 2.474, 0.034, 3.198, 3.552, 0.165, 0.570, 0.484, 1.558, 1.381, 0.117, 0.034, 0.536, 2.455, 1.765, 0.973, 0.044, 3.889, 0.327, 0.013, 0.394, 0.141, 0.354)
vararr = sort(x)
F = function(t){z<-x[x<t]; length(z)/length(x)}
mean <- sum(x)/length(x)
variance<-sum(x^2)/length(x)-mean^2

if(length(vararr) %% 2 != 0){
  median<-vararr[(length(vararr)-1)/2]
} else {
  median<-(vararr[(length(vararr))/2]+vararr[(length(vararr)+2)/2])/2
}

assymmetry<-sum((x-mean)^3)/(length(x)*variance^(3/2))
excess<-(sum((x-mean)^4)/(length(x)*variance^2))-3

c <- 0
d <- 2
P <- F(d)-F(c)

TI = function(a2) {
  mean<-sum(x)/length(x)
  xa<-qnorm (1-a2/2)
  return(c(
    1/mean-xa/sqrt(mean*mean*length(x)),
    1/mean+xa/sqrt(mean*mean*length(x))
  ))
}

#e
lambda0 <- 0.5; 
Fy<-ecdf(x)
Fexp <- pexp(x,lambda0)
Diff <- array(dim=50)
for(i in 1:length(x)){
  Diff[i]<-abs(Fy(x[i])-Fexp[i])
}
D<-max(Diff)
Dn<-D*sqrt(length(x))

#f
cur = 0.4
arr = c()
while (length(x[x < cur]) - length(x[x < cur - 0.4]) > 0) {
  arr = c(arr, length(x[x < cur]) - length(x[x < cur - 0.4]))
  cur = cur+0.4
}


arr = c()
for (cur in seq(0.4, 3.6, by = 0.4)) {
  arr = c(arr, pexp(cur, 0.9825499) - pexp(cur - 0.4, 0.9825499))
}

TIi = function(a2) {
  mean<-sum(x)/length(x)
  xa<-qnorm (1-a2/2)
  return(c(
    1/(mean+xa*mean*sqrt(2/length(x))),
    1/(mean-xa*mean*sqrt(2/length(x))) 
  ))
}

lambda0 = 0.5; 
Fy = ecdf(x)
lambda = 0.5
Fgamma = pgamma(x, 0.5, lambda / 2)
Diff = array(dim=50)
for(i in 1:length(x)){
  Diff[i] = abs(Fy(x[i])-Fgamma[i])
}
D = max(Diff)
Dn<-D*sqrt(length(x))
