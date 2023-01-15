data{
  int<lower=1>  n;
  int<lower=1>  p;
  matrix[n,p]   X;
  int           y[n];
  real     offset[n];
}
parameters{
  vector[p]     beta;
}
model{
  vector[n] loglam;

  beta ~ normal(0,10);

  //loglam = X*beta;
  for(i in 1:n){
    loglam[i] = dot_product(X[i,], beta) + offset[i];
  }
  y ~ poisson_log(loglam);

}
