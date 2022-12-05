model {

  # Priors
  taun   <- 1.0/sigman
  lambda ~ dnorm(mun, taun)T(0.0,)

  # Likelihood
  for(i in 1:n){
    s[i] ~ dpois(lambda)
  }

}
