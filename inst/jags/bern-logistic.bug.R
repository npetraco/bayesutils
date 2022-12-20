model {

  # Prior
  alpha ~ dlogis(0,1)

  # Likelihood
  for(i in 1:n){
    y[i] ~ dbern( exp(alpha)/(1+exp(alpha)) )
  }

  ppi <- exp(alpha)/(1+exp(alpha))

}
