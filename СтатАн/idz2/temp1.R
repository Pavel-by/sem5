x <- c(0.589, 0.596, 0.215, 0.664, 0.323, 0.005, 2.487, 0.662, 0.584,
        0.031, 1.136, 1.494, 2.698, 1.516, 0.839, 0.186, 2.173, 1.014, 0.198,
        0.344, 2.269, 0.209, 1.609, 0.803, 0.228, 1.382, 1.763, 0.413, 2.474,
        0.034, 3.198, 3.552, 0.165, 0.570, 0.484, 1.558, 1.381, 0.117, 0.034,
        0.536, 2.455, 1.765, 0.973, 0.044, 3.889, 0.327, 0.013, 0.394, 0.141,
        0.354)
vararr <- sort(x)

x = sort(x)
lambda0 <- 0.5;
Fy<-ecdf(x)
Fexp <- pexp(x,lambda0)
Diff <- array(dim=50)
for(i in 1:length(x)){
  Diff[i]<-abs(Fy(x[i])-Fexp[i])
}
D<-max(Diff)
Dn<-D*sqrt(length(x))
print(Dn)

plot(x, Diff, type='l')

print(
  data.frame(
    x = x,
    Fn = sapply(x, Fy),
    Fexp = round(Fexp, 4),
    Diff = round(Diff, 4)
  )
)