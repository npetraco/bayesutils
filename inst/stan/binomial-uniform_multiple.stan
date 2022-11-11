data {
  int<lower=0>  N;
  int<lower=0>  n[N];
  int<lower=0>  s[N];
  real          a_hyp;
  real          b_hyp;
}
parameters {
  real<lower=0,upper=1> ppi[N]; // individual ppis
  //real<lower=0,upper=1> ppi;  // mean ppi
}
model {
  //Prior
  ppi ~ uniform(a_hyp,b_hyp);

  //likelihood (vectorized form)
  s ~ binomial(n, ppi);
}
generated quantities {
  //Get the overall ppi
  real mean_ppi = mean(ppi);
}

