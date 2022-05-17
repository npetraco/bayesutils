model {

  # Likelihood
  for (i in 1:N) {
    t[i] ~ dexp(lambda)
  }

  # Priors
  tau ~ dgamma(alpha, beta)
  lambda <- 1/tau # inverse-gamma

}
