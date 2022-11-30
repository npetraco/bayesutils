model {

  # Priors
  taun   <- 1.0/sigman
  taut   <- 1.0/sigmat
  phi    ~ dt(mut, taut, nu)T(0.0,)

  # Likelihood
  for(i in 1:n){
    lambda[i] ~ dnorm(mun, taun)T(0.0,)
    h[i]      ~ dgamma(phi, phi)
    s[i] ~ dpois(lambda[i]*h[i])
  }

}
