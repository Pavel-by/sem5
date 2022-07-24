sz <- 5

res = sample(c(TRUE, FALSE), sz, replace=TRUE)
res = sapply(res, function(x) {
  if (x)
    return(rnorm(1))
  else
    return(rexp(1))
})
print(res)