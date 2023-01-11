data {
  int<lower=0>  n;
  int<lower=0>  s[n];
  real<lower=0> a;
  real<lower=0> b;
}
parameters {
  real<lower=0> lambda;
}
model {
  //Prior
  target += gamma_lpdf(lambda | a,b);

  //likelihood
  //target += poisson_lpmf(s | lambda);
  for(i in 1:n){
    target += poisson_lpmf(s[i] | lambda);
  }

}
generated quantities {
  vector[n] log_lik;

  for(i in 1:n){
    log_lik[i] = poisson_lpmf(s[i] | lambda);
  }

}
