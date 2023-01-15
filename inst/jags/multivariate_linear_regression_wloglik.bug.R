model{

  # Priors
  alpha ~ dt(mu_alpha, 1/sig_alpha^2, nu_alpha)
  for(i in 1:p) {
    beta[i]  ~ dt(mu_beta, 1/sig_beta^2, nu_beta)
  }
  sigma ~ dnorm(mu_sigma, 1/sig_sigma^2)T(0.0,)

  # Likelihood and Log-likelihood
  for(i in 1:n) {
    y[i] ~ dnorm(alpha + inprod(beta, X[i,]), 1/sigma^2)
    log_lik[i] <- log( dnorm(y[i], alpha + inprod(beta, X[i,]), 1/sigma^2) )
  }

}
