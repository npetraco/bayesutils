model{
  # Priors
  mu ~ dt(mu_hyp, 1/(sigma_hyp^2), nu_hyp)
  sigma ~ dunif(a_hyp, b_hyp)

  # Likelihood
  for(i in 1:n) {
    x[i] ~ dnorm(mu, 1/(sigma^2))
  }

}
