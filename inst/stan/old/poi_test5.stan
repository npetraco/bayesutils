data{
  int<lower=1>  n;
  int<lower=1>  p;
  matrix[n,p]   X;
  real          sig_beta;
  int           y[n];
  //real     offset[n];
}
parameters{
  vector[p] beta;
}
model{

  // Priors
  beta ~ normal(0,sig_beta);

  // Likelihood
  for(i in 1:n) {
    target += poisson_log_lpmf(y[i] | dot_product(X[i,], beta));
  }

}
