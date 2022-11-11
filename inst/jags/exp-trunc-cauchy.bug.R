model{
  # Likelihood
  for(i in 1:n){
    t[i] ~ dexp(lambda)
  }

  # Priors
  lambda ~ dt(mu, tau, 1)T(0.1,) # Cauchy = stud.T w/ nu=1
}
