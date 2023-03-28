model{
  # Priors
  for(i in 1:N){
    ppi[i] ~ dunif(a_hyp, b_hyp)
  }

  # Likelihood
  for(i in 1:N){
    s[i] ~ dbinom(ppi[i], n[i])
  }

  # Get the overall ppi
  mean_ppi <- mean(ppi[])
}
