data {
  int<lower=0>  n;
  int<lower=0>  s[n];
  real<lower=0> mun;
  real<lower=0> sigman;
}
parameters {
  real<lower=0> lambda;
}
model {
  //Prior
  lambda ~ normal(mun, sigman);

  //likelihood (vectorized)
  s ~ poisson(lambda);

}
