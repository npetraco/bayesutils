model{

  # Priors
  alpha ~ dt(mu_alpha, 1/sig_alpha^2, nu_alpha)
  beta  ~ dt(mu_beta, 1/sig_beta^2, nu_beta)
  sigma ~ dnorm(mu_sigma, 1/sig_sigma^2)T(0.0,)

  # Likelihood
  for(i in 1:n){
    mu[i] <- alpha + beta * x[i]
    y[i] ~ dnorm(mu[i], 1/sigma^2)
  }

}
