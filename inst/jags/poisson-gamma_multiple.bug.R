model{
  # Priors
  for(j in 1:m){
    lambda[j] ~ dgamma(a, b)
  }

  # Likelihood
  for(j in 1:m){
    for(i in 1:n){
      s[i,j] ~ dpois(lambda[j])
    }
  }
}
