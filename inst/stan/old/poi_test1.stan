data{
  int<lower=0>              N;
  int<lower=0>              n_eth;
  int<lower=0, upper=n_eth> eth[N];
  vector[N]                 offeset;
  int<lower=0>              stops[N];
}
parameters {
  //real          mu;
  //real<lower=0> sigma_eth;
  vector[n_eth] b_eth;
  vector[N]     lambda;
}
model {
  //mu        ~ normal(0, 100);
  //sigma_eth ~ normal(0, 10);
  //b_eth     ~ normal(0, sigma_eth);
  b_eth     ~ normal(0, 10);

  for (i in 1:N) {
    //lambda[i] = offeset[i] + mu + b_eth[eth[i]];
    lambda[i] = offeset[i] + b_eth[eth[i]];
  }

  stops ~ poisson_log(lambda);
}
