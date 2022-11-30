model {

  # Priors
  taun   <- 1.0/sigman
  taut   <- 1.0/sigmat
  lambda ~ dnorm(mun, taun)T(0.0,)
  phi    ~ dt(mut, taut, nu)T(0.0,)

  # Likelihood
  for(i in 1:n){
    #phi/(phi+lambda) is p parameter
    s[i] ~ dnegbin(phi/(phi+lambda), phi)
  }

}
