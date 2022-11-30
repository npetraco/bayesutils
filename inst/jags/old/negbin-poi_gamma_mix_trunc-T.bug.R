model {

  # Priors
  taut   <- 1.0/sigmat
  phi    ~ dt(mut, taut, nu)T(0.0,)
  ppi    ~ dbeta(1,1)
  op <- ppi/(1-ppi)
  lambda ~ dgamma(phi, op)

  # Likelihood
  for(i in 1:n){
    s[i] ~ dpois(lambda)
  }

}
