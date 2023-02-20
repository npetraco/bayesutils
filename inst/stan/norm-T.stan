data {
  real          ybar;
  real<lower=0> sigma;
  int<lower=0>  n;
  real<lower=0> mu_hyp;
  real<lower=0> sigma_hyp;
  int<lower=0>  nu_hyp;
}
parameters {
  real mu;
}
model {
  //Prior
  mu ~ student_t(nu_hyp,mu_hyp,sigma_hyp);
  //likelihood (vectorized form)
  ybar ~ normal(mu, sigma/sqrt(n));
}
generated quantities {
  //posterior predictive distribution
  real ypred = normal_rng(mu,sigma);
}
