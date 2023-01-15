data {
  int<lower=0>  nA;
  int<lower=0>  nB;
  vector[nA]    DA;
  vector[nB]    DB;
  int<lower=0>  nu_fix;
  real<lower=0> muA_n_hyp;
  real<lower=0> sigmaA_n_hyp;
  int<lower=0>  nuA_t_hyp;
  real<lower=0> muA_t_hyp;
  real<lower=0> sigmaA_t_hyp;
  real<lower=0> muB_n_hyp;
  real<lower=0> sigmaB_n_hyp;
  int<lower=0>  nuB_t_hyp;
  real<lower=0> muB_t_hyp;
  real<lower=0> sigmaB_t_hyp;
}
parameters {
  real muA;
  real<lower=0> sigmaA;
  real muB;
  real<lower=0> sigmaB;
}
model {
  //Priors
  target += normal_lpdf(muA | muA_n_hyp, sigmaA_n_hyp);
  target += student_t_lpdf(sigmaA | nuA_t_hyp, muA_t_hyp, sigmaA_t_hyp);
  target += normal_lpdf(muB | muB_n_hyp, sigmaB_n_hyp);
  target += student_t_lpdf(sigmaB | nuB_t_hyp, muB_t_hyp, sigmaB_t_hyp);

  //Likelihood
  target += student_t_lpdf(DA | nu_fix, muA, sigmaA);
  target += student_t_lpdf(DB | nu_fix, muB, sigmaB);
}
generated quantities {
  real          log_lik[nA+nB];
  vector[nA+nB] D;

  D = append_row(DA,DB);

  // For DA with muA sigmaA
  for(i in 1:nA) {
    log_lik[i] = student_t_lpdf(D[i] | nu_fix, muA, sigmaA);
  }

  // For DB with muB sigmaB
  for(i in (nA+1):(nA+nB)) {
    log_lik[i] = student_t_lpdf(D[i] | nu_fix, muB, sigmaB);
  }


}
