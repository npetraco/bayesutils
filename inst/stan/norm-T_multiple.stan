data {
  int<lower=0>  n;
  int<lower=0>  p;
  matrix[n,p]   X;
  real<lower=0> mu_t_hyp;
  real<lower=0> sigma_t_hyp;
  int<lower=0>  nu_t_hyp;
}
parameters {
  real          mu;
  real<lower=0> sigma;
}
model {

  //Prior
  mu    ~ student_t(nu_t_hyp,mu_t_hyp,sigma_t_hyp);
  sigma ~ student_t(nu_t_hyp,mu_t_hyp,sigma_t_hyp);

  //likelihood (vectorized form)
  for(i in 1:n){
    X[i,] ~ normal(mu, sigma);
  }

}
