data {
  int<lower=1>  n_cols;  // was k
  int<lower=1>  n_rows;
  int<lower=0>  count[n_rows, n_cols];
  vector[n_rows] alpha_hyp;
}
parameters {
  simplex[n_rows] ppi_vecs[n_cols]; // basically a matrix who's columns are simplices. However, see generated quantities
}
model{

  // For a matrix of counts, columns of ppi are independent and sum to 1
  for(i in 1:n_cols){

    // prior
    ppi_vecs[i] ~ dirichlet(alpha_hyp);

    // likelihood
    count[,i] ~ multinomial(ppi_vecs[i]);
  }

}
generated quantities {
  // For some reason the ppi simplex vectors are getting stored as rows instead of columns
  // Rearrange them into a matrix where the columns are ppi
  matrix[n_rows,n_cols] ppi;
  for(i in 1:n_cols) {
    ppi[,i] = ppi_vecs[i];
  }
}
