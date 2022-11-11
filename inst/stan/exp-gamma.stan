data {
  int<lower=0>  n;
  real<lower=0> t[n];
  real<lower=0> a;
  real<lower=0> b;
}
parameters {
  real<lower=0> lambda;
}
model {
  //Prior
  lambda ~ gamma(a,b);

  //likelihood (vectorized form)
  t ~ exponential(lambda);
}
