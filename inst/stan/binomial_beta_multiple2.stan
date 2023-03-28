data {
  int<lower=0>  num_total_trials;
  int<lower=0>  n[num_total_trials];
  int<lower=0>  s[num_total_trials];
  real<lower=0> a;
  real<lower=0> b;
}
parameters {
  real<lower=0,upper=1> ppi[num_total_trials]; // Verion 2 ppi for each trial
}
model {
  // proir on p_heads:
  for(i in 1:num_total_trials) {
    target += beta_lpdf(ppi[i] | a, b);
  }

  // likelihood:
  for(i in 1:num_total_trials) {
    target += binomial_lpmf(s[i] | n[i], ppi[i]);
  }

}
