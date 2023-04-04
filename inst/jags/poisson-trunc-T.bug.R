model{

  #Priors
  for(i in 1:n) {
    lambda[i] ~ dt(mu_hyp, 1/sig_hyp^2, nu_hyp)T(0,)
  }

  #Likelihood
  for(i in 1:n){
    for(j in 1:m){
      s[i,j] ~ dpois(lambda[i])
    }
  }

}
