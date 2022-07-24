# ANOVA
n<-50
sig<-1
n.lev<-5
cf<-rexp(n.lev)*3
al<-0.05
# generate
z0<-sample(c(1:n.lev),n,replace=TRUE)
x<-z0
y<-cf[z0]+rnorm(n,10,sig)
dat<-data.frame(y=y,x=x)
dat1<-dat[order(x),]
# Linear model (code)
n<-length(y)
lev<-levels(as.factor(z0))
n.lev<-length(lev)
Y<-as.matrix(dat1$y)
X<-matrix(0,nrow=n.lev,ncol=n)
for (i in 1:n){
  X[dat1$x[i],i]<-1
}
S<-X%*%t(X)
S1<-solve(S)
bhat<-S1%*%X%*%Y
# check manually 
# plot
plot(x,y,main="ANOVA")
x1<-lev
y1<-bhat
points(x1,y1,col="red",lwd=2,pch=19)
points(x1,y1,"l",col="red",lwd=2)
# central
tt<-table(x)
v<-as.matrix(array(1/n.lev,dim=n.lev))
mu<-matrix(t(v)%*%bhat,nrow=n.lev,ncol=1)
ahat<-bhat-mu
res<-Y-t(X)%*%as.matrix(bhat)
SS<-sum(res^2)
s2<-SS/(n-n.lev)
# 
CTR<-diag(1,n.lev)-matrix(v,nrow=n.lev,ncol=n.lev)
C0<-as.matrix(v)
muhat<-t(C0)%*%bhat
V.mu<-t(C0)%*%S1%*%C0
ahat<-t(CTR)%*%bhat
V.a<-t(CTR)%*%S1%*%CTR
V<-diag(V.a)
xa<-qt(1-al/2,n-n.lev)
s1<-sqrt(s2)
d0<-xa*s1*sqrt(V.mu)
CI0<-data.frame(parameter="mu",cntr=muhat,lw=muhat-d0,up=muhat+d0)
d<-xa*s1*sqrt(V)
nm<-paste0("a",c(1:n.lev))
CI<-data.frame(parameter=nm,cntr=ahat,lw=ahat-d,up=ahat+d)
CI1<-rbind(CI0,CI)
# From the maximal level
v<-c(array(0,dim=n.lev-1),1)
CTR<-diag(1,n.lev-1)
CTR<-t(cbind(CTR,-as.matrix(array(1,dim=n.lev-1))))
C0<-as.matrix(v)
muhat<-t(C0)%*%bhat
V.mu<-t(C0)%*%S1%*%C0
ahat<-t(CTR)%*%bhat
V.a<-t(CTR)%*%S1%*%CTR
V<-diag(V.a)
xa<-qt(1-al/2,n-2)
s1<-sqrt(s2)
d0<-xa*s1*sqrt(V.mu)
CI0<-data.frame(parameter="mu",cntr=muhat,lw=muhat-d0,up=muhat+d0)
d<-xa*s1*sqrt(V)
nm<-paste0("a",c(1:(n.lev-1)))
CI<-data.frame(parameter=nm,cntr=ahat,lw=ahat-d,up=ahat+d)
CI1<-rbind(CI0,CI)
# Errors distribution
hh<-hist(res,breaks=5,plot=FALSE)
nu<-hh$counts
brk<-hh$breaks
# check counts
l.b<-length(brk)
r<-l.b-1
csq0<-function(s){
  if (s>0){
    p<-pnorm(brk[2:l.b],0,s)-pnorm(brk[1:(l.b-1)],0,s)
    return(sum((nu-n*p)^2/n/p))
  } else {
    return(Inf)
  }
}
csq.s<-nlm(csq0,p=sqrt(s2))$minimum
pv<-pchisq(csq.s,r-2,lower.tail=FALSE)
# H0 #
kolm.stat<-function(s){
  sres<-sort(res)
  fdistr<-pnorm(sres,0,s)
  max(abs(c(0:(n-1))/n-fdistr),abs(c(1:n)/n-fdistr))
}
ks.dist<-nlm(kolm.stat,p=sqrt(s2))$minimum
plot.ecdf(res)
x2<-c(0:1000)*(max(res)-min(res))/1000+min(res)
y2<-pnorm(x2,0,nlm(kolm.stat,p=sqrt(s2))$estimate)
points(x2,y2,"l",col="red",lwd=2)
# Hypothesis
SH<-sum((y-mean(y))^2)
SSE<-SS
df.e<-n-n.lev
SSH<-SH-SSE
df.h<-n.lev-1
ssh<-SSH/df.h
sse<-SSE/df.e
FST<-ssh/sse
xal<-qf(1-al,df.h,df.e)
pv.f<-pf(FST,df.h,df.e,lower.tail=FALSE)
# ANOVA (realization)
x1<-as.factor(x)
q<-lm(y~x1)
qs<-summary(q)
bhat<-q$coefficients
res<-q$residuals
CI<-confint(q)
V<-diag(qs$cov.unscaled)
s1<-qs$sigma
FST<-qs$fstatistic
pv<-qs$coefficients[2,4]








