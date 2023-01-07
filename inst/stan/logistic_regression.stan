data{
  int<lower=1>  n;
  int<lower=1>  p;
  matrix[n,p]   X;
  int           y[n];
  int<lower=1>  nu_alpha;
  real          mu_alpha;
  real<lower=0> sig_alpha;
  int<lower=1>  nu_beta;
  real          mu_beta;
  real<lower=0> sig_beta;
}
parameters{
  real          alpha;
  vector[p]     beta;
}
model{

  //Priors
  target += student_t_lpdf(alpha | nu_alpha, mu_alpha, sig_alpha);
  for(i in 1:p) {
    target += student_t_lpdf(beta[i] | nu_beta, mu_beta, sig_beta);
  }

  //Likelihood. Note: Bernoulli-Logit(y| eta ) = Bernoulli(y∣ inv-logit(eta) )
  for(i in 1:n) {
    target += bernoulli_logit_lpmf(y[i] | alpha + dot_product(beta, X[i,]) );
  }

}
generated quantities{
  real eta[n];
  real ppi[n];   // pi = the mean mu

  for(i in 1:n){
    eta[i] = alpha + dot_product(beta, X[i,]);
  }

  ppi = inv_logit(eta);
}
