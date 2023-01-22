model{

  # Likelihood
  s ~ dbin(ppi, n)
  logit(ppi) <- theta

  # Priors
  theta ~ dnorm(mu, pow(sigma,-2)) # parameterized in terms of tau (precision)
  # tau = 1/sigma^2
}
