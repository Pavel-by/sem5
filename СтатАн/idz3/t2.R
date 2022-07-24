x <- c(2, 5, 0, 6, 3, 3, 2, 4, 6, 6, 0, 3, 3, 1, 2, 4, 4, 5, 0, 4, 3, 6, 6, 5, 5, 6, 6, 1, 6, 5, 4, 2, 5, 2, 2, 3, 3, 1, 5, 3, 3, 0, 0, 5, 2, 5, 1, 3, 3, 3)
y <- c(8.07, 10.94, 10.22, 8.81, 7.28, 14.70, 9.04, 9.37, 11.02, 5.40, 12.19, 11.16, 9.15, 9.61, 11.57, 8.43, 13.15, 9.70, 15.20, 8.27, 8.78, 10.92, 9.37, 10.01, 10.65, 14.03, 7.33, 13.59, 4.79, 11.43, 8.77, 10.70, 10.05, 6.31, 5.79, 13.04, 10.91, 14.07, 15.33, 9.61, 9.28, 14.22, 8.45, 8.55, 7.35, 11.75, 11.32, 10.74, 8.01, 7.37)

#plot(x,y,main="Result")

XM = matrix(c(array(1,dim=50),x),nrow=2,ncol=50,byrow=TRUE) # X regressors matrix
S = XM %*% t(XM) 
YM = as.matrix(y)
S1 = solve(S)
bht = S1 %*% XM %*% YM;
eps<-(YM-t(XM)%*%bht)
xx<-c(0,1,2,3,4,5,6)
yy<-bht[1]+bht[2]*xx
points(xx,yy,"l",col="red")

eps<-(YM-t(XM)%*%bht)
n = length(y)
r = dim(XM)[1] 
SSE = sum(eps^2) 
sht = SSE/(n-r) 

kolm.stat<-function(s){
  sres<-sort(eps)
  fdistr<-pnorm(sres,0,s)
  max(
    abs(c(0:(n-1))/n-fdistr),
    abs(c(1:n)/n-fdistr)
  )
}
ks.dist<-nlm(kolm.stat,p=sqrt(sht))$minimum
plot.ecdf(eps)
x2<-c(0:1000)*(max(eps)-min(eps))/1000+min(eps)
y2<-pnorm(x2,0,nlm(kolm.stat,p=sqrt(s2))$estimate)
points(x2,y2,"l",col="red",lwd=2)