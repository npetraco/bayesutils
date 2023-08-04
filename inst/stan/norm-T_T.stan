data {
  int<lower=0>  n;
  real          x[n];
  int<lower=0>  mu_nu_hyp;
  real          mu_mu_hyp;
  real<lower=0> mu_sig_hyp;
  int<lower=0>  sigma_nu_hyp;
  real          sigma_mu_hyp;
  real<lower=0> sigma_sig_hyp;
}
parameters {
  real           mu;
  real <lower=0> sigma;
}
model {
  //Prior
  mu    ~ student_t(mu_nu_hyp, mu_mu_hyp, mu_sig_hyp);
  sigma ~ student_t(sigma_nu_hyp, sigma_mu_hyp, sigma_sig_hyp);

  //Likelihood (vectorized form)
  x ~ normal(mu, sigma);
}
