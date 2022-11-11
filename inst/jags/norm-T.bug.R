model{
  # Priors
  mu ~ dt(mu_hyp, 1/(sigma_hyp^2), nu_hyp)

  # Likelihood
  se <- sigma/sqrt(n)
  ybar ~ dnorm(mu, 1/(se^2))

  # Posterior predictive distribution
  ypred ~ dnorm(mu, 1/(sigma^2))
}
