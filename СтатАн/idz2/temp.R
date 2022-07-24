a1 = 0.01
breaks = c(0.4, 0.8, 1.2, 1.6, 2.4)
Fn = function(t) {
  z <- x[x < t]
  return(length(z))
}

ni = c()
for (i in 1:(length(breaks)+1)) {
  if (i == 1)
    ni = c(ni, Fn(breaks[i]))
  else if (i == length(breaks)+1)
    ni = c(ni, n - Fn(breaks[i-1]))
  else
    ni = c(ni, Fn(breaks[i]) - Fn(breaks[i-1]))
}

pi = c()
Fv = function(t) {
  l = 0.9825499
  return(pgamma(t, 0.5, l/2))
}
for (i in 1:(length(breaks)+1)) {
  if (i == 1)
    pi = c(pi, Fv(breaks[i]))
  else if (i == length(breaks)+1)
    pi = c(pi, 1 - Fv(breaks[i-1]))
  else
    pi = c(pi, Fv(breaks[i]) - Fv(breaks[i-1]))
}

npi = pi*n
X2 = sum((ni-npi)^2/npi)
xa = pchisq(X2, length(breaks)-1,lower.tail = FALSE)
X2_lim = qchisq(a1, length(breaks)-1, lower.tail = FALSE)
