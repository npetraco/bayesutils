data {
  int<lower=0>  n;
  int<lower=0>  m;
  int<lower=0>  s[n,m];
  real<lower=0> a;
  real<lower=0> b;
}
parameters {
  real<lower=0> lambda[m];
}
model {
  //Prior
  lambda ~ gamma(a,b);

  //likelihood (vectorized form)
  for(j in 1:m){
    s[,j] ~ poisson(lambda[j]);
  }

}
