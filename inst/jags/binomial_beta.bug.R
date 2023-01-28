model{

  # Likelihood
  s ~ dbin(p_heads, n)

  # Prior:
  p_heads ~ dbeta(a,b)

}
