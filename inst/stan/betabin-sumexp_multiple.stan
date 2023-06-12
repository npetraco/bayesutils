data{
  real<lower=0> lambda;  // Fixed hyper parameter for the prior
  int<lower=0>  m;      // Number of item tested
  int<lower=0>  n[m];   // Number of times each item tested
  int<lower=0>  s[m];   // Observed number of counts with s <= n
}
parameters{
  //real<lower=1e-8> alpha[m];
  //real<lower=1e-8> beta[m];
  real<lower=0> alpha[m];
  real<lower=0> beta[m];

}
transformed parameters{
  //real<lower=1e-8> theta[m];
  real<lower=0> theta[m];

  for(i in 1:m) {
    theta[i] = alpha[i] + beta[i];
  }

}
model{

  for(i in 1:m) {
    // Priors
    target += exponential_lpdf(theta[i] | lambda);

    // Likelihood
    target += beta_binomial_lpmf(s[i] | n[i], alpha[i], beta[i]);
  }

}
generated quantities{
  real ppi[m];          // probability of a "success"
  real rho[m];          // dispersion parameter
  for(i in 1:m){
    ppi[i] = alpha[i]/(alpha[i]+beta[i]);
    rho[i] = 1/(alpha[i]+beta[i]+1);
  }
}
