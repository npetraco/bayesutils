data{
  real<lower=0> lambda;  // Fixed hyper parameter for the prior
  int<lower=0>  m;      // Number of item tested
  int<lower=0>  n[m];   // Number of times each item tested
  int<lower=0>  s[m];   // Observed number of counts with s <= n
}
parameters{
  real<lower=0> alpha;
  real<lower=0> beta;
}
model{

  // Priors
  //alpha ~ exponential(lambda); // See comment below. These did not lead to strange behavior. Just switched to target format to be consistent with liklihood
  //beta  ~ exponential(lambda);
  target += exponential_lpdf(alpha | lambda);
  target += exponential_lpdf(beta | lambda);

  // Likelihood (vectorize???? check. don't think so)
  for(i in 1:m) {
    //s[i] ~ beta_binomial(n[i], alpha, beta); // Track down: There should be basically no difference between this and below but, for some reason this runs super slow and does not reach equilibrium, at least in some cases..... cf. try out on fbbf data set in bayesutils
    target += beta_binomial_lpmf(s[i] | n[i], alpha, beta);
  }

}
generated quantities{
  real ppi;          // probability of a "success"
  real phi;          // dispersion parameter
  ppi = alpha/(alpha+beta);
  phi = 1/(alpha+beta+1);
}
