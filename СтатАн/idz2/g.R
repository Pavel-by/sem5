
lambda<-0.6
a1<-0.1
c<-0
a0<-ppois(c,lambda*length(x))
while (a0<a1) 
{
  c<-c+1;
  a0<-ppois(c,lambda*length(x))
}
c<-c-1
print(c)
p<-(a1-ppois(c,lambda*length(x)))/dpois(c,lambda*length(x))
print(p)
print(a0)
