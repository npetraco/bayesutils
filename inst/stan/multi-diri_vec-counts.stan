data {
  int<lower=0>  k;
  int<lower=0>  count[k];
  vector[k]     alpha_hyp;
}
parameters {
  simplex[k] ppi;
}
model {
  //Prior
  ppi ~ dirichlet(alpha_hyp);

  //likelihood (vectorized form)
  count ~ multinomial(ppi);
}
