model{
  # Priors
  ppi ~ dunif(a_hyp, b_hyp)

  # Likelihood
  s ~ dbinom(ppi, n)

}
