data{
  real<lower=0> lambda;  // Fixed hyper parameter for the prior
  int<lower=0>  m;      // Number of item tested
  int<lower=0>  n[m];   // Number of times each item tested
  int<lower=0>  s[m];   // Observed number of counts with s <= n
  int<lower=0, upper=1> priorOnlySwitch;
}
parameters{
  real<lower=0> alpha;
  real<lower=0> beta;
}
transformed parameters{
  real<lower=0> theta = alpha + beta;
}
model{

  // Priors
  target += exponential_lpdf(theta | lambda);

  // Likelihood
  // Turn on likelihood for full model (priorOnlySwitch=0), otherwise prior simulated only  (priorOnlySwitch=1).
  // For figure making purposes.
  if(priorOnlySwitch == 0) {
    for(i in 1:m) {
      target += beta_binomial_lpmf(s[i] | n[i], alpha, beta);
    }
  }

}
generated quantities{
  real ppi;          // probability of a "success"
  real phi;          // dispersion parameter
  ppi = alpha/(alpha+beta);
  phi = 1/(alpha+beta+1);
}
