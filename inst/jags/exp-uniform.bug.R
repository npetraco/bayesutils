model{
  # Likelihood
  for(i in 1:n){
    t[i] ~ dexp(lambda)
  }

  # Priors
  lambda ~ dunif(a, b)
}
