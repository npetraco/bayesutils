data{
  int  <lower=0> N;
  real <lower=0> t[N];
  real <lower=0> alpha;
  real <lower=0> beta;
}
parameters{
  real <lower=0> lambda;
}
model{
  target += inv_gamma_lpdf(lambda | alpha, beta);
  target += exponential_lpdf(t | lambda);
}
