model{

  # Likelihood
  for(i in 1:n){
    s[i] ~ dpois(lambda)
  }

  # Priors
  lambda ~ dgamma(a, b)
}
