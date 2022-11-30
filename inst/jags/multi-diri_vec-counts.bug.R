model{

  # prior
  ppi ~ ddirch(alpha_hyp)

  # likelihood
  count ~ dmulti(ppi, n)

}
