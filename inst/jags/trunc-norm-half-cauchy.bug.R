model{

  # Prior
  sigma_sq ~ dt(loc, 1/(scale^2), 1)T(0.0,) # cauchy is student-T with k=1

  # Likelihood
  for(i in 1:n){
    x[i] ~ dnorm(xbar, 1/sigma_sq)T(0.0,)
  }

  sigma <- sqrt(sigma_sq)

}
