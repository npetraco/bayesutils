data {
  int<lower=0>  n;
  int<lower=0>  s;
  real<lower=0> a;
  real<lower=0> b;
}
parameters {
  real<lower=0,upper=1> ppi;
}
model {
  // proir on p_heads:
  ppi ~ beta(a, b);

  // likelihood:
  s ~ binomial(n, ppi);
}
