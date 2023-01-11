data {
  int<lower=0>                  N;
  int<lower=0>                  n_eth;
  int<lower=0>                  n_precint;
  int<lower=0, upper=n_precint> precint[N];
  int<lower=0, upper=n_eth>     eth[N];
  vector[N]                     offeset;
  int<lower=0>                  stops[N];
}
parameters {
  vector[n_eth] b_eth;
  vector[n_precint] b_precint;
}
model {
  vector[N] loglambda;

  b_eth ~ normal(0, 10);
  b_precint ~ normal(0, 10);

  for (i in 1:N) {
    loglambda[i] = offeset[i] + b_eth[eth[i]] + b_precint[precint[i]];
  }

  stops ~ poisson_log(loglambda);
}
