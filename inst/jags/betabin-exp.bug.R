model{

  # Priors
  alpha ~ dexp(lambda)
  beta  ~ dexp(lambda)

  # Likelihood
  for(i in 1:m) {
    s[i] ~ dbetabin(alpha, beta, n[i])
  }

  ppi <- alpha/(alpha+beta);
  phi <- 1/(alpha+beta+1);

}
