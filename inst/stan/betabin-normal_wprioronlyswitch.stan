data{
  int<lower=0, upper=1> priorOnlySwitch;
  real         mu;    // Fixed hyperparameter for the prior
  real         sigma; // Fixed hyperparameter for the prior
  int<lower=0> m;     // Number of item tested
  int<lower=0> n[m];  // Number of times each item tested
  int<lower=0> x[m];  // Observed number of "successes" on each item
}
parameters{
  real<lower=1e-8> alpha;
  real<lower=1e-8> beta;
}
model{
  alpha ~ normal(mu,sigma);
  beta  ~ normal(mu,sigma);

  // Turn on likelihood for full model (priorOnlySwitch=0), otherwise prior simulated only  (priorOnlySwitch=1).
  // For figure making purposes.
  if(priorOnlySwitch == 0) {
    for(i in 1:m) {
      //x[i] ~ beta_binomial(n[i],alpha,beta);
      target += beta_binomial_lpmf(x[i] | n[i], alpha, beta);
    }
  }

}
generated quantities{
  real ppi; //mean "success" probability on each bernoulli trial
  real phi; //correlation between bernoulli trials
  ppi = alpha/(alpha+beta);
  phi = 1/(alpha+beta+1);
}
