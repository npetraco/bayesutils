data {
  int<lower=0>  n;
  vector[n]     t;
  real<lower=0> mu;
  real<lower=0> sigma;
}
parameters {
  real<lower=0.1> lambda;
}
model {
  //Prior
  lambda ~ cauchy(mu, sigma);
  //likelihood (vectorized form)
  t ~ exponential(lambda);
}
