data {
  int<lower=0>  n;
  real          x[n];
  int<lower=0>  nu_hyp;
  real          mu_hyp;
  real<lower=0> sigma_hyp;
  real          a_hyp;
  real          b_hyp;
}
parameters {
  real           mu;
  real <lower=0> sigma;
}
model {
  //Prior
  mu    ~ student_t(nu_hyp,mu_hyp,sigma_hyp);
  sigma ~ uniform(a_hyp, b_hyp);

  //Likelihood (vectorized form)
  x ~ normal(mu, sigma);
}
