model {

  # Priors
  taun   <- 1.0/sigman^2
  taut   <- 1.0/sigmat^2
  lambda ~ dnorm(mun, taun)T(0.0,)
  phi    ~ dt(mut, taut, nu)T(0.0,)

  # Likelihood
  for(i in 1:n){
    #phi/(phi+lambda) is p parameter for dnegbin
    s[i] ~ dnegbin(phi/(phi+lambda), phi)
  }

}
