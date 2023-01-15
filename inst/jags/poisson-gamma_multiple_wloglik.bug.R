model{
  # Priors
  for(j in 1:m){
    lambda[j] ~ dgamma(a, b)
  }

  # Likelihood and Log-likelihood
  for(j in 1:m){
    for(i in 1:n){

      s[i,j] ~ dpois(lambda[j])
      log_lik[(i*m + j) - 1] <- log( dpois(s[i,j], lambda[j]) ) # Hack: To give row major address (i,j) a unique index (i*m + j) - 1.  Must do this since jags can't update a variable value in a loop. It is a declarative language, not a procedural one.
                                                                # These indices are just names, so it doesn't matter what we call them
    }
  }
}
