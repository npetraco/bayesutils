data {
  int<lower=0>  n;
  int<lower=0>  s[n];
  real<lower=0> mun;
  real<lower=0> sigman;
  real<lower=0> mut;
  real<lower=0> sigmat;
  int<lower=0>  nu;
}
parameters {
  real<lower=0> lambda;
  real<lower=0> phi;
}
transformed parameters {
  real<lower=0> phi_inv = 1.0/phi;
}
model {
  //Priors
  lambda  ~ normal(mun,sigman);
  phi     ~ student_t(nu,mut,sigmat);

  //likelihood (vectorized form)
  s ~ neg_binomial_2(lambda, phi);
}
