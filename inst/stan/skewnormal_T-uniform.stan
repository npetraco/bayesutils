data {
  int<lower=0>  n;
  vector[n]     X;
  real          a_hyp;
  real          b_hyp;
  real<lower=0> mu_t_hyp;
  real<lower=0> sigma_t_hyp;
  int<lower=0>  nu_t_hyp;
}
parameters {
  real          mu;
  real          alpha;
  real<lower=0> sigma;

}
model {

  //Prior
  mu    ~ student_t(nu_t_hyp,mu_t_hyp,sigma_t_hyp);
  sigma ~ student_t(nu_t_hyp,mu_t_hyp,sigma_t_hyp);
  alpha ~ uniform(a_hyp, b_hyp);  // This prior is leading to a ton of divergent transitions.....????

  //likelihood (vectorized form)
  X ~ skew_normal(mu, sigma, alpha);

}
