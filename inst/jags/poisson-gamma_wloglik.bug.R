model{

  # Likelihood and Log-likelihood
  for(i in 1:n){
    s[i] ~ dpois(lambda)

    log_lik[i] = log(dpois(s[i], lambda))
  }

  # Priors
  lambda ~ dgamma(a, b)

}
