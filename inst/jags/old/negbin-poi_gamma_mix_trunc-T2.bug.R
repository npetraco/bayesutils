model {

  # Priors
  taun   <- 1.0/sigman
  taut   <- 1.0/sigmat
  lambda ~ dnorm(mun, taun)T(0.0,)
  phi    ~ dt(mut, taut, nu)T(0.0,)
  h      ~ dgamma(phi, phi)

  # Likelihood
  for(i in 1:n){
    s[i] ~ dpois(lambda*h)
  }

}
