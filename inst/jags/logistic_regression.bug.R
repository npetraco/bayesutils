model{

  # Priors
  alpha ~ dt(mu_alpha, 1/sig_alpha^2, nu_alpha)
  for(i in 1:p) {
    beta[i] ~ dt(mu_beta, 1/sig_beta^2, nu_beta)
  }

  # Likelihood
  for(i in 1:n) {

    logit(ppi[i]) <- alpha + inprod(beta, X[i,])

    y[i] ~ dbin(ppi[i], 1)

  }

}
