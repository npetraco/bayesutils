data {
  int<lower=0>  n;
  real          y[n];
  int<lower=0>  nu_fix;
  real<lower=0> mu_n_hyp;
  real<lower=0> sigma_n_hyp;
  int<lower=0>  nu_t_hyp;
  real<lower=0> mu_t_hyp;
  real<lower=0> sigma_t_hyp;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  //Prior
  mu    ~ normal(mu_n_hyp, sigma_n_hyp);
  sigma ~ student_t(nu_t_hyp, mu_t_hyp, sigma_t_hyp);

  //likelihood (vectorized form)
  y ~ student_t(nu_fix, mu, sigma);
}
