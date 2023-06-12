data{
  int<lower=0>  m;     // Number of item tested
  int<lower=0>  n[m];  // Number of times each item tested
  int<lower=0>  s[m];  // Observed number of "successes" on each item
  real          nu_hyp;  // Fixed hyperparameter for the prior
  real<lower=0> mu_hyp;  // Fixed hyperparameter for the prior
}
parameters{
  real<lower=1e-8> alpha;
  real<lower=1e-8> beta;
  real<lower=1e-8> sigma_alpha; // Flat prior on sigma_alpha
  real<lower=1e-8> sigma_beta; // Flat prior on sigma_beta
}
model{

  // Priors
  alpha ~ student_t(nu_hyp, mu_hyp, sigma_alpha);
  beta  ~ student_t(nu_hyp, mu_hyp, sigma_beta);

  // Likelihood
  for(i in 1:m) {
    //x[i] ~ beta_binomial(n[i],alpha,beta);
    target += beta_binomial_lpmf(s[i] | n[i], alpha, beta);
  }


}
generated quantities{
  real ppi; //mean "success" probability on each bernoulli trial
  real phi; //correlation between bernoulli trials
  ppi = alpha/(alpha+beta);
  phi = 1/(alpha+beta+1);
}
