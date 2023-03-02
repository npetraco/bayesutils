data {
  int<lower=0>  n;
  vector[n]     X;
  real          mu_mu_t_hyp;
  real<lower=0> mu_sigma_t_hyp;
  int<lower=0>  mu_nu_t_hyp;
  real<lower=0> sigma_mu_t_hyp;
  real<lower=0> sigma_sigma_t_hyp;
  int<lower=0>  sigma_nu_t_hyp;
  real          alpha_mu_t_hyp;
  real<lower=0> alpha_sigma_t_hyp;
  int<lower=0>  alpha_nu_t_hyp;
}
parameters {
  //real<lower=0> mu;
  //real<lower=0> alpha;
  real          mu;
  real          alpha;
  real<lower=0> sigma;
}
model {

  //Prior
  mu    ~ student_t(mu_nu_t_hyp,    mu_mu_t_hyp,    mu_sigma_t_hyp);
  sigma ~ student_t(sigma_nu_t_hyp, sigma_mu_t_hyp, sigma_sigma_t_hyp);
  alpha ~ student_t(alpha_nu_t_hyp, alpha_mu_t_hyp, alpha_sigma_t_hyp);

  //likelihood (vectorized form)
  X ~ skew_normal(mu, sigma, alpha);

}
