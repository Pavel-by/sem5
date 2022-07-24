y = c(47.89, 48.26, 47.39, 48.14, 47.71, 47.41, 49.01, 48.95, 48.25, 49.16, 48.69, 49.66, 48.51, 47.79, 48.36, 50.18, 48.62, 48.84, 50.07, 50.25, 49.46, 50.81, 50.64, 49.86, 52.05, 51.04, 51.83, 51.84, 52.08, 53.34, 53.00, 53.72, 54.33, 53.16, 52.97, 52.63, 44.21, 44.51, 45.39, 44.81, 43.08, 45.31, 45.22, 46.48, 45.78, 45.28, 46.76, 45.51)
z2 = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4)
z1 = c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2)

dat<-data.frame(y=y,x1=z1,x2=z2)
dat1<-dat[order(z1,z2),]
dat1$x<-NA
n.lev1<-length(levels(as.factor(dat1$x1)))
n.lev2<-length(levels(as.factor(dat1$x2)))
# Linear model (code)
k<-n.lev1*n.lev2
z1.l<-as.numeric(t(matrix(levels(as.factor(z1)),nrow=n.lev1,ncol=n.lev2)))
z2.l<-as.numeric(matrix(levels(as.factor(z2)),nrow=n.lev2,ncol=n.lev1))
t.code<-matrix(ncol=3,nrow=n.lev1*n.lev2)
#
k<-0
for (i in 1:n.lev1)
  for (j in 1:n.lev2){
    k<-k+1
    dat1$x[dat1$x1==i & dat1$x2==j]<-k
    t.code[k,1]<-i
    t.code[k,2]<-j
    t.code[k,3]<-k
  }
t.code<-as.data.frame(t.code)
names(t.code)<-c("z1","z2","x")
# Estimation
n<-length(y)
lev<-levels(as.factor(dat1$x))
n.lev<-length(lev)
Y<-as.matrix(dat1$y)
X<-matrix(0,nrow=n.lev,ncol=n)
for (i in 1:n){
  X[dat1$x[i],i]<-1
}
S<-X%*%t(X)
S1<-solve(S)
bhat<-S1%*%X%*%Y

# çàäàíèå 2
beta<-t(matrix(bhat,nrow=n.lev2,ncol=n.lev1))
xx<-c(1:n.lev2)
yx1<-beta[1,]
yx2<-beta[2,]
sym<-c(1:2)
plot(NULL,NULL,"n",xlab="A",ylab="Y",col="blue",main="ANOVA TWO WAY",xlim=c(min(xx),max(xx)), ylim=c(min(y),max(y)))
points(z2[z1==1],y[z1==1],col="red",pch=2)
points(z2[z1==2],y[z1==2],col="blue",pch=3)
points(xx,yx1,col="red","l",lwd=2)
points(xx,yx1,col="red",lwd=2,pch=19)
points(xx,yx2,"l",col="blue",lwd=2)
points(xx,yx2,col="blue",lwd=2,pch=19)

res<-Y-t(X)%*%as.matrix(bhat)
SS<-sum(res^2)
s2<-SS/(n-k)
# central weights
v1<-c(array(0,dim=n.lev1-1),1)
v2<-c(array(0,dim=n.lev2-1),1)

C0<-as.matrix(as.numeric(v1%o%v2))
C1<-matrix(0,nrow=k,ncol=n.lev1)
for (i in 1:n.lev1){ C1[t.code$x[t.code$z1==i],i]<-v2 }
C1<-C1-matrix(C0,nrow=k,ncol=n.lev1)
C2<-matrix(0,nrow=k,ncol=n.lev2)
for (i in 1:n.lev2){ C2[t.code$x[t.code$z2==i],i]<-v1 }
C2<-C2-matrix(C0,nrow=k,ncol=n.lev2)
C12<-diag(k)
for (j in 1:k){
  C12[,j]<-C12[,j]-C1[,t.code$z1[t.code$x==j]]
  C12[,j]<-C12[,j]-C2[,t.code$z2[t.code$x==j]]
  C12[,j]<-C12[,j]-C0
}
muhat<-t(C0)%*%bhat
V.mu<-t(C0)%*%S1%*%C0
ahat1<-t(C1)%*%bhat
V.a1<-t(C1)%*%S1%*%C1
V1<-diag(V.a1)
ahat2<-t(C2)%*%bhat
V.a2<-t(C2)%*%S1%*%C2
V2<-diag(V.a2)
itr<-t(C12)%*%bhat
V.itr<-t(C12)%*%S1%*%C12
V12<-diag(V.itr)

al = 0.2
xa<-qt(1-al/2,n-k)
s1<-sqrt(s2)
d0<-xa*s1*sqrt(V.mu)
CI0<-data.frame(parameter="mu",cntr=muhat,lw=muhat-d0,up=muhat+d0)
d<-xa*s1*sqrt(V1)
nm1<-paste0("B",c(1:n.lev1))
CI1<-data.frame(parameter=nm1,cntr=ahat1,lw=ahat1-d,up=ahat1+d)
d<-xa*s1*sqrt(V2)
nm2<-paste0("A",c(1:n.lev2))
CI2<-data.frame(parameter=nm2,cntr=ahat2,lw=ahat2-d,up=ahat2+d)
d<-xa*s1*sqrt(V12)
nm12<-paste0("int",t.code$z2,":",t.code$z1)
CI12<-data.frame(parameter=nm12,cntr=itr,lw=itr-d,up=itr+d)

hh<-hist(res,breaks=seq(from=-1.5, to=2, by=0.63))
nu<-hh$counts
brk<-hh$breaks

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

#------------------------
ftr<-colSums(abs(C12))!=0
C12.r<-C12[,ftr]
BZ12<-t(C12.r)%*%S1%*%C12.r
BZ12.inv<-solve(BZ12)
itr<-t(C12.r)%*%bhat
SSH12<-t(itr)%*%BZ12.inv%*%itr
df12<-length(itr)
SSH12.m<-SSH12/df12
SSE<-SS
dfe<-(n-k)
SSE.m<-SS/dfe
FST12<-SSH12.m/SSE.m
pv12<-pf(FST12,df12,dfe,lower.tail=FALSE)
# anova table (SSH is additive for balanced data)
ftr1<-colSums(abs(C1))!=0
C1.r<-C1[,ftr1]
BZ1<-t(C1.r)%*%S1%*%C1.r
BZ1.inv<-solve(BZ1)
ahat1<-t(C1.r)%*%bhat
SSH1<-t(ahat1)%*%BZ1.inv%*%ahat1
df1<-length(ahat1)
SSH1.m<-SSH1/df1
#
ftr2<-colSums(abs(C2))!=0
C2.r<-C2[,ftr2]
BZ2<-t(C2.r)%*%S1%*%C2.r
BZ2.inv<-solve(BZ2)
ahat2<-t(C2.r)%*%bhat
SSH2<-t(ahat2)%*%BZ2.inv%*%ahat2
df2<-length(ahat2)
SSH2.m<-SSH2/df2
# 
nm<-c("Âçàèìîäåéñòâèÿ A:B","Ôàêòîğ A","Ôàêòîğ Â","Îøèáêè")
ss<-c(SSH12,SSH1,SSH2,SSE)
df<-c(df12,df1,df2,dfe)
mss<-c(SSH12.m,SSH1.m,SSH2.m,SSE.m)
AOV.table<-data.frame("Èñòî÷íèê_äèñïåğñèè"=nm,"SS"=ss,"DF"=df,"Mean_SS"=mss)
# ANOVA (realization)
x1<-relevel(as.factor(z1),"2")
x2<-relevel(as.factor(z2),"4")
q<-lm(y~x1*x2)
qs<-summary(q)
coeff<-q$coefficients
res<-q$residuals
CI<-confint(q)
V<-diag(qs$cov.unscaled)
s1<-qs$sigma
aov.table<-anova(q)
SSE<-aov.table["Residuals","Sum Sq"]
dfe<-aov.table["Residuals","df"]
SSH12<-aov.table["x1:x2","Sum Sq"]
# Additive
qa<-lm(y~x1+x2)
qa.a<-anova(qa,q)
SSH12<-qa.a["1","RSS"]-SSE
SSH12<-qa.a["2","Sum of Sq"]
#
qz1<-lm(y~x2)
anova(qz1,q)
#
qz2<-lm(y~x1)
anova(qz2,q)
# 
qh1<-lm(y~x1:x2-x1)
qh1.a<-anova(qh1,q)