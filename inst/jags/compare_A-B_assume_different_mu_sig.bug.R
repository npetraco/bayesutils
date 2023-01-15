model{
  # Priors
  muA    ~ dnorm(muA_n_hyp, 1/sigmaA_n_hyp^2)
  sigmaA ~ dt(muA_t_hyp, 1/sigmaA_t_hyp^2, nuA_t_hyp)T(0,)
  muB    ~ dnorm(muB_n_hyp, 1/sigmaB_n_hyp^2)
  sigmaB ~ dt(muB_t_hyp, 1/sigmaB_t_hyp^2, nuB_t_hyp)T(0,)

  # Likelihood
  for(i in 1:nA){
    DA[i] ~ dt(muA, 1/sigmaA^2, nu_fix)
  }
  for(i in 1:nB){
    DB[i] ~ dt(muA, 1/sigmaA^2, nu_fix)
  }

}
