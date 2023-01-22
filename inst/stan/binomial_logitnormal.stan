data{
  int n;
  int s;
  real mu;
  real <lower=0> sigma;
}
parameters{
  real Z;
}
model{
  Z ~ normal(mu,sigma);
  s ~ binomial_logit(n,Z);
}
generated quantities{
  real ppi;
  ppi = inv_logit(Z);
}
