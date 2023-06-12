data{
  int<lower=0>  m;     // Number of item tested
  int<lower=0>  n[m];  // Number of times each item tested
  int<lower=0>  s[m];  // Observed number of "successes" on each item
  real          nu_hyp;  // Fixed hyperparameter for the prior
  real<lower=0> mu_hyp;  // Fixed hyperparameter for the prior
  real<lower=0> sig_hyp; // Fixed hyperparameter for the prior
  int<lower=0, upper=1> priorOnlySwitch;
}
parameters{
  real<lower=1e-8> alpha;
  real<lower=1e-8> beta;
}
model{

  // Priors
  alpha ~ student_t(nu_hyp, mu_hyp, sig_hyp);
  beta  ~ student_t(nu_hyp, mu_hyp, sig_hyp);

  // Likelihood
  // Turn on likelihood for full model (priorOnlySwitch=0), otherwise prior simulated only  (priorOnlySwitch=1).
  // For figure making purposes.
  if(priorOnlySwitch == 0) {
    for(i in 1:m) {
      //x[i] ~ beta_binomial(n[i],alpha,beta);
      target += beta_binomial_lpmf(s[i] | n[i], alpha, beta);
    }
  }


}
generated quantities{
  real ppi;          // mean "success" probability on each bernoulli trial
  real phi;          // correlation between bernoulli trials
  vector[m] log_lik; // log likelihood for loo
  // Compute pi and phi:
  ppi = alpha/(alpha+beta);
  phi = 1/(alpha+beta+1);

  // Compute log likelihoods for loo
  // Only do this for the full model (priorOnlySwitch == 1)
  if(priorOnlySwitch == 0) {
    for(i in 1:m) {
      log_lik[i]= beta_binomial_lpmf(s[i] | n[i], alpha, beta);
    }
  } else {
    log_lik = rep_vector(0.0, m);
  }

}
