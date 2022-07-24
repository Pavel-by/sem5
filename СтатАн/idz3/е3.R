library(ellipse)
al = 0.01
C<-matrix(c(c(1,0), c(0,1)),nrow=2, ncol=2)
BVar<-matrix(nrow=2,ncol=2)
XXt<-XM%*%t(XM)
xal<-qt(1-al/2,df=n-2)
BVar<-t(C)%*%solve(XXt)%*%C
b0low<-bht[1]-xal*sqrt(sht)*sqrt(BVar[1,1])
print(b0low)
b0up<-bht[1]+xal*sqrt(sht)*sqrt(BVar[1,1])
print(b0up)
b1low<-bht[2]-xal*sqrt(sht)*sqrt(BVar[2,2])
print(b1low)
b1up<-bht[2]+xal*sqrt(sht)*sqrt(BVar[2,2])
print(b1up)


C<-diag(c(1,1))
ph<-bht
V<-diag(S1) 
al = 0.01
xa<-qt(1-al/2,n-2)
s1<-sqrt(s2)
d<-xa*s1*sqrt(V)
CI<-data.frame(lw=ph-d,up=ph+d)

mu <- c(mean(x),mean(y))
P <- as.matrix(CI)
plot(x, y)
#lines(ellipse(P, centre = mu, level = 0.99), col='blue')