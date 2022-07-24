vectors = list(
  x = runif(1000, -1, 1),
  y = rnorm(1000),
  z = rnorm(1000, sd=10),
  t = rnorm(1000, mean=0.01)
)

vnames = names(vectors)

for (n in vnames) {
  vt = t.test(vectors[[n]]);
  print(paste0("Estimate of ", n, ": ", vt$estimate))
}

for (i in 1:(length(vectors)-1)) {
  for (j in (i+1):length(vectors)) {
    n1 = vnames[i]
    n2 = vnames[j]
    
    vst = t.test(vectors[[n1]], vectors[[n2]])
    
    print(paste(n1, "and", n2, "estimates are", 
                if (vst$estimate[1] == vst$estimate[2]) "equals" 
                else "not equals"))
  }
}