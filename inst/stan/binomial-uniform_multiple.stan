data {
  int<lower=0>  N;
  int<lower=0>  n[N];
  int<lower=0>  s[N];
  real          a_hyp;
  real          b_hyp;
}
parameters {
  real<lower=0,upper=1> ppi[N];
}
model {
  //Prior
  ppi ~ uniform(a_hyp,b_hyp);

  //likelihood (vectorized form)
  s ~ binomial(n, ppi);
}
generated quantities {
  real mean_ppi;

  mean_ppi = mean(ppi);

}
