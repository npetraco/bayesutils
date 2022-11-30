model{

  # For a matrix of counts. columns of ppi are independent and sum to 1
  for(i in 1:n_cols){

    # prior
    ppi[1:n_rows, i] ~ ddirch(alpha_hyp)

    # likelihood
    count[,i] ~ dmulti(ppi[1:n_rows,i], n[i])
  }

}
