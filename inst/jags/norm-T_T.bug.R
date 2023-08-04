model{
  # Priors
  mu    ~ dt(mu_mu_hyp, 1/(mu_sig_hyp^2), mu_nu_hyp)
  sigma ~ dt(sigma_mu_hyp, 1/(sigma_sig_hyp^2), sigma_nu_hyp)


  # Likelihood
  for(i in 1:n) {
    x[i] ~ dnorm(mu, 1/(sigma^2))
  }

}
