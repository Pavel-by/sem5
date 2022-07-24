x = seq(from = 0, to = 2 * pi, length.out = 1000)
mtable = data.frame(
  x,
  sin(x),
  sin(x) + rnorm(n = 1000, sd = 0.005)
)

newframe = rbind(
  head(mtable, 100),
  tail(mtable, 50)
)

print(head(newframe, 5))
print(tail(newframe, 5))

plot(mtable[[1]], mtable[[2]], type="l", xlab = "X", ylab = "sin(x)")
plot(mtable[[1]], mtable[[3]], type="l", xlab = "X", ylab = "sin(x) + N(0, 0.005)")