data {
  int<lower=0>  n;
  real<lower=0> s_sq;
  real<lower=0> loc;
  real<lower=0> scale;
}
parameters {
  real<lower=0> sigma_sq;
}
transformed parameters{
  real<lower=0> x;
  x = (n-1)*s_sq/sigma_sq; // This is distributed as chi-sq(n-1)
}
model {
  //Prior
  //sigma_sq ~ cauchy(loc, scale);
  target += cauchy_lpdf(sigma_sq | loc, scale);

  //likelihood
  //x ~ chi_square(n-1); // Wrong: No Jacobian
  target += chi_square_lpdf(x | n-1) + log(n-1) - 2*log(sigma_sq);

}
generated quantities {
  real<lower=0> sigma;
  sigma = sqrt(sigma_sq);
}
