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
  target += gamma_lpdf(lambda | a,b);

  //likelihood
  for(j in 1:m){
    for(i in 1:n){
       target += poisson_lpmf(s[i,j] | lambda[j]);
    }
  }

}
generated quantities {
  vector[m*n] log_lik;
  int count;

  count = 1;
  for(j in 1:m){
    for(i in 1:n){
       log_lik[count] = poisson_lpmf(s[i,j] | lambda[j]);
       count = count + 1;
    }
  }
}
