data{
  int<lower=1>  n;
  int<lower=1>  p;
  matrix[n,p]   X;
  real          y[n];
  int<lower=1>  nu_alpha;
  real          mu_alpha;
  real<lower=0> sig_alpha;
  int<lower=1>  nu_beta;
  real          mu_beta;
  real<lower=0> sig_beta;
  real          mu_sigma;
  real<lower=0> sig_sigma;
}
parameters{
  real          alpha;
  vector[p]     beta;
  real<lower=0> sigma;
}
model{

  //Priors
  target += student_t_lpdf(alpha | nu_alpha, mu_alpha, sig_alpha);
  for(i in 1:p) {
    target += student_t_lpdf(beta[i] | nu_beta, mu_beta, sig_beta);
  }
  target += normal_lpdf(sigma | mu_sigma, sig_sigma);

  //Likelihood
  for(i in 1:n) {
    target += normal_lpdf(y[i] | alpha + dot_product(beta, X[i,]), sigma);
  }

}
generated quantities{
  real log_lik[n];
  for(i in 1:n){
    log_lik[i] = normal_lpdf(y[i] | alpha + dot_product(beta, X[i,]), sigma);
  }
}
