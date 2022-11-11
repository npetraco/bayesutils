data {
  int<lower=0>  n;
  int<lower=0>  s;
  real          a_hyp;
  real          b_hyp;
}
parameters {
  real<lower=0,upper=1> ppi;
}
model {
  //Prior
  ppi ~ uniform(a_hyp,b_hyp);

  //likelihood (vectorized form)
  s ~ binomial(n, ppi);
}
