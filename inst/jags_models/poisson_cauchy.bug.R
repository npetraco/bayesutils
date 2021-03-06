model{

  # Likelihood
  for (i in 1:N) {
    y[i] ~ dpois(lambda[i])
    log(lambda[i]) <- alpha + inprod(Mmodl[i,],theta[])
  }

  # Priors
  alpha ~ dt(0,0.01,1)       # Cauchy with percision = 1/scale^2, scale = 10
  for(i in 1:p) {
    theta[i] ~ dt(0,0.001,1) # Cauchy with percision = 1/scale^2, scale = 30
  }

}
