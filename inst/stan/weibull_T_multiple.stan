data {
  int<lower=0>  n;
  vector[n]     y;
  real          alpha_mu_t_hyp;
  real<lower=0> alpha_sigma_t_hyp;
  int<lower=0>  alpha_nu_t_hyp;
  real<lower=0> sigma_mu_t_hyp;
  real<lower=0> sigma_sigma_t_hyp;
  int<lower=0>  sigma_nu_t_hyp;
}
parameters {
  real<lower=0> alpha; // shape
  real<lower=0> sigma; // scale
}
model {

  //Prior
  sigma ~ student_t(sigma_nu_t_hyp, sigma_mu_t_hyp, sigma_sigma_t_hyp);
  alpha ~ student_t(alpha_nu_t_hyp, alpha_mu_t_hyp, alpha_sigma_t_hyp);

  //likelihood (vectorized form)
  y ~ weibull(alpha, sigma);

}
