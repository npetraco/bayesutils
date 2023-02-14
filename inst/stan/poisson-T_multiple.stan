data {
  int<lower=0>  n;
  int<lower=0>  m;
  int<lower=0>  s[n,m];
  real<lower=0> nu_hyp;
  real<lower=0> mu_hyp;
  real<lower=0> sig_hyp;
}
parameters {
  real<lower=0> lambda[m];
}
model {
  //Prior (vectorized)
  lambda ~ student_t(nu_hyp, mu_hyp, sig_hyp);

  //Likelihood
  for(j in 1:m){
    for(i in 1:n){
      s[i,j] ~ poisson(lambda[j]);
    }
  }
}
