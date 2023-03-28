data {
  int<lower=0>  n;
  real<lower=0> s_sq[n];
  real<lower=0> nu_hyp;
  real<lower=0> mu_hyp;
  real<lower=0> sig_hyp;
}
parameters {
  real<lower=0> sigma_sq;
}
transformed parameters{
  real<lower=0> x[n];
  for(i in 1:n){
    x[i] = (n-1)*s_sq[i]/sigma_sq; // This is distributed as chi-sq(n-1)
  }

}
model {
  //Prior
  target += student_t_lpdf(sigma_sq | nu_hyp, mu_hyp, sig_hyp);

  //likelihood
  for(i in 1:n){
    target += chi_square_lpdf(x[i] | n-1) + log(n-1) - 2*log(sigma_sq);
  }

}
generated quantities {
  real<lower=0> sigma;
  sigma = sqrt(sigma_sq);
}
