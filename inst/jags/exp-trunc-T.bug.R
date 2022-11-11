model{
  # Likelihood
  for(i in 1:n){
    t[i] ~ dexp(lambda)
  }

  # Priors
  lambda ~ dt(mu, tau, nu)T(0.1,)
}
