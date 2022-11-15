model{
  # Priors
  mu    ~ dnorm(mu_n_hyp, 1/sigma_n_hyp^2)
  sigma ~ dt(mu_t_hyp, 1/sigma_t_hyp^2, nu_t_hyp)T(0,)

  # Likelihood
  for(i in 1:n){
    y[i] ~ dt(mu, 1/sigma^2, nu_fix)
  }

}
