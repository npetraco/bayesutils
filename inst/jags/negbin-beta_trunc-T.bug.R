model {

  # Priors
  taut   <- 1.0/sigmat^2
  ppi    ~ dbeta(alpha, beta)
  phi    ~ dt(mut, taut, nu)T(0.0,)

  # Likelihood
  for(i in 1:n){
    s[i] ~ dnegbin(ppi, phi)
  }
  lambda <- (phi*(1-ppi))/ppi

}
