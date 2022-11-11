data {
  int<lower=0>  n;
  int<lower=0>  s[n];
  real<lower=0> a;
  real<lower=0> b;
}
parameters {
  real<lower=0> lambda;
}
model {
  //Prior
  lambda ~ gamma(a,b);

  //likelihood
  s ~ poisson(lambda);

}
