model{

  # Priors
  for(i in 1:p) {
    beta[i] ~ dt(mu_beta, 1/sig_beta^2, nu_beta)
  }

  # Likelihood
  for(i in 1:n) {

    log(lambda[i]) <- offset[i] + inprod(beta, X[i,])

    y[i] ~ dpois(lambda[i])

  }

}
