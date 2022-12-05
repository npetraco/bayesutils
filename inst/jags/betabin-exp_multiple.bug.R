model{

  for(i in 1:m) {

    # Priors
    alpha[i] ~ dexp(lambda)
    beta[i]  ~ dexp(lambda)

    # Likelihood
    s[i] ~ dbetabin(alpha[i], beta[i], n[i])

    ppi[i] <- alpha[i]/(alpha[i] + beta[i]);
    phi[i] <- 1/(alpha[i] + beta[i] + 1);

  }

}
