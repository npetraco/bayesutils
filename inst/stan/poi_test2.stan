data{
  int<lower=0>              N;
  int<lower=0>              n_eth;
  int<lower=0, upper=n_eth> eth[N];
  vector[N]                 offeset;
  int<lower=0>              stops[N];
}
parameters {
  vector[n_eth] b_eth;
}
model {
  b_eth     ~ normal(0, 10);

  for (i in 1:N) {
    stops[i] ~ poisson_log(offeset[i] + b_eth[eth[i]]);
  }

}
generated quantities {
  vector[N]     lambda;

  for (i in 1:N) {
    lambda[i] = offeset[i] + b_eth[eth[i]];
  }

}
