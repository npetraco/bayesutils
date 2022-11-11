data {
  int<lower=0>  n;
  vector[n]     t;
  real<lower=0> a;
  real<lower=0> b;
}
parameters {
  real<lower=a> lambda;
}
model {
  //Prior
  lambda ~ uniform(a,b);

  //likelihood (vectorized form)
  t ~ exponential(lambda);
}
