data {
  int<lower=0>  nA;
  int<lower=0>  nB;
  real          DA[nA];
  real          DB[nB];
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
  target += normal_lpdf(mu | mu_n_hyp, sigma_n_hyp);
  target += student_t_lpdf(sigma | nu_t_hyp, mu_t_hyp, sigma_t_hyp);

  //likelihood
  target += student_t_lpdf(DA | nu_fix, mu, sigma);
  target += student_t_lpdf(DB | nu_fix, mu, sigma);
}
