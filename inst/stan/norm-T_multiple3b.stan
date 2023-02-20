data {
  int<lower=0>  n;
  int<lower=0>  p;
  matrix[n,p]   X;
  real<lower=0> mu_t_hyp;
  real<lower=0> sigma_t_hyp;
  int<lower=0>  nu_t_hyp;
}
parameters {
  vector[n]          mu_x;
  vector<lower=0>[n] sigma_x;
  real               mu_mus;
  real<lower=0>      sigma_mus;
  real<lower=0>      sigma_sigs;
}
model {

  // Hyperprior
  mu_mus     ~ student_t(nu_t_hyp, mu_t_hyp, sigma_t_hyp);
  sigma_mus  ~ student_t(nu_t_hyp, mu_t_hyp, sigma_t_hyp);
  sigma_sigs ~ student_t(nu_t_hyp, mu_t_hyp, sigma_t_hyp);

  //Prior
  mu_x    ~ student_t(nu_t_hyp,mu_mus,sigma_mus);
  sigma_x ~ student_t(nu_t_hyp,mu_t_hyp,sigma_sigs);

  //likelihood (vectorized form)
  for(i in 1:n){
    X[i,] ~ normal(mu_x[i], sigma_x[i]);
  }

}
