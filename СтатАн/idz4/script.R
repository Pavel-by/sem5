x = c(2, 5, 0, 6, 3, 3, 2, 4, 6, 6, 0, 3, 3, 1, 2, 4, 4, 5, 0, 4, 3, 6, 6, 5, 5, 6, 6, 1, 6, 5, 4, 2, 5, 2, 2, 3, 3, 1, 5, 3, 3, 0, 0, 5, 2, 5, 1, 3, 3, 3)
y = c(2.86, 21.74, 2.88, 13.82, 12.77, 7.80, 8.15, 13.10, 5.45, 17.09, 11.98, 5.83, 6.89, 12.17, 8.55, 9.84, 11.41, 20.62, 8.25, 13.34, 7.05, 10.65, 9.62, 0.80, 17.62, 11.37, 18.72, 22.91, 8.16, 8.35, 19.17, 5.06, 6.93, 2.81, 14.26, 12.71, 11.74, 4.46, 3.63, 12.11, 16.59, 9.63, 8.89, 10.93, 18.07, 4.63, 11.11, 5.06, 4.70, 16.94)
n = length(x)

dat = data.frame(y=y, x=x)
dat1 = dat[order(x),]

lev = levels(as.factor(x))
n.lev = length(lev)
Y = as.matrix(dat1$y)
X = matrix(0, nrow = n.lev, ncol = n)
for (i in 1:n)
  X[dat1$x[i]+1, i] = 1
S = X %*% t(X)
S1 = solve(S)
bhat = S1 %*% X %*% Y

v = as.matrix(array(1/n.lev, dim=n.lev))
mu = matrix(t(v) %*% bhat, nrow = n.lev, ncol = 1)
ahat = bhat - mu
res = Y - t(X) %*% as.matrix(bhat)
SS = sum(res^2)
s2 = SS / (n - n.lev) # несмещенная оценка дисперсии

CTR = diag(1, n.lev) - matrix(v, nrow = n.lev, ncol = n.lev)
C0 = as.matrix(v)
muhat = t(C0) %*% bhat
V.mu = t(C0) %*% S1 %*% C0
ahat = t(CTR) %*% bhat
V.a = t(CTR) %*% S1 %*% CTR
V = diag(V.a)
al = 0.05
xa = qt(1 - al/2, n - n.lev)
s1 = sqrt(s2)
d0 = xa * s1 * sqrt(V.mu)

d = xa * s1 * sqrt(V)
CI = data.frame(cntr = ahat, lw = ahat-d, up = ahat+d)

# max level
v = c(array(0,dim=n.lev-1),1)
CTR = diag(1,n.lev-1)
CTR = t(cbind(CTR,-as.matrix(array(1,dim=n.lev-1))))
C0 = as.matrix(v)
muhat = t(C0)%*%bhat
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