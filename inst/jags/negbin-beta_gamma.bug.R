model {

  # Priors
  ppi    ~ dbeta(alphab, betab)
  phi    ~ dgamma(alphag, betag)

  # Likelihood
  for(i in 1:n){
    s[i] ~ dnegbin(ppi, phi)
  }
  lambda <- (phi*(1-ppi))/ppi

}
