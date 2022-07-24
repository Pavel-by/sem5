
x0 <- array(1, dim=n)
X <- t(matrix(c(x0, x, x^2), nrow=n, ncol=3))
Y <- as.matrix(y)
S <- X%*%t(X)
S1 <- solve(S)
bht <- S1%*%X%*%Y

res <- Y - t(X) %*% as.matrix(bht)
SS <- sum(res^2)
s2 <- SS/(n-3)

FST <- bht[3]^2/S1[2, 2]/sht
pv.f <- pf(FST, 1, n-3, lower.tail=FALSE)

