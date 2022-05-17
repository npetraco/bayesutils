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
  lambda ~ inv_gamma(alpha,beta);
  t ~ exponential(lambda);
}
