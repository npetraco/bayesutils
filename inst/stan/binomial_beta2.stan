data {
  int<lower=0>  n;
  int<lower=0>  s;
  real<lower=0> a;
  real<lower=0> b;
}
parameters {
  real<lower=0,upper=1> p_heads; // In here we just changed ppi to p_heads
}
model {
  // proir on p_heads:
  p_heads ~ beta(a, b);

  // likelihood:
  s ~ binomial(n, p_heads);
}
