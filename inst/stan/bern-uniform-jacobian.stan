data {
  int<lower=0>  n;
  int<lower=0>  y[n];
}
parameters {
  real alpha; // log odds
}
transformed parameters {
  real <lower=0, upper=1> ppi;
  ppi = exp(alpha)/(1+exp(alpha));
}
model {

  // Prior (includeds log jacobian for transform, log(dppi/dalpha) )
  target += uniform_lpdf(ppi | 0, 1) + alpha - 2*log(1+exp(alpha));

  // Likelihood
  target += bernoulli_lpmf(y | ppi);

}
