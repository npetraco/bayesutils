data{
  int<lower=1> n;
  int<lower=1> p;
  matrix[n,p]  X;
  int          y[n];
  vector[n]    offset;
  real         nu_beta;
  real         mu_beta;
  real         sig_beta;
}
parameters{
  vector[p] beta;
}
model{

  //Priors
  for(i in 1:p) {
    target += student_t_lpdf(beta[i] | nu_beta, mu_beta, sig_beta);
  }

  // Likelihood (computationally efficient form. Cf. https://mc-stan.org/docs/2_25/functions-reference/poisson-log-glm.html)
  target += poisson_log_glm_lpmf(y | X, offset, beta);
}
