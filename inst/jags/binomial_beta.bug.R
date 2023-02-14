model{

  # Likelihood
  s ~ dbin(ppi, n)

  # Prior:
  ppi ~ dbeta(a,b)

}
