arr = c()
lambda = 0.9825499
for (cur in seq(0.4, 3.6, by = 0.4)) {
  arr = c(arr, pgamma(cur, 0.5, lambda / 2) - pgamma(cur - 0.4, 0.5, lambda / 2))
}

lambda<-1
a2<-0.01
C<-qnorm(a2,50/lambda,sqrt(2*50)/lambda)
