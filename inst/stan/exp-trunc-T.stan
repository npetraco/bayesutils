data {
  int<lower=0>  n;
  vector[n]     t;
  real<lower=0> mu;
  real<lower=0> sigma;
  int<lower=0>  nu;
}
parameters {
  real<lower=0.1> lambda;
}
model {
  //Prior
  lambda ~ student_t(nu,mu,sigma);
  //likelihood (vectorized form)
  t ~ exponential(lambda);
}
