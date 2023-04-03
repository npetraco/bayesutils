library(bayesutils)

file.edit(system.file("jags/binomial_logitnormal.bug.R", package = "bayesutils"))

file.edit(system.file("stan/binomial_logitnormal.stan", package = "bayesutils"))

get.mfp("binomial_logitnormal.bug.R")
get.mfp("binomial_logitnormal.bug")
get.mfp("binomial_logitnormal.stan")

get.mfp("binomial_logitnormal.R.bug")

"bug.r" %in% c("bug", "bug.R", "stan")

op.mf("binomial_logitnormal.bug.R")
op.mf("binomial_logitnormal.bug")
op.mf("binomial_logitnormal.stan")

get_model_file_path("binomial_logitnormal.bug")

read.mf(model.file.name = "normal-T.stan", model.path = "/Users/karen2/Desktop/")

get.script("binomial-logitnormal_JAGS.R")
get.script("ex2_norm-T_control_STAN.R")
open_model_file("norm-T.stan")


get.script("ex1_prior_plots.R")
op.mf("exp-gamma.bug")
op.mf("exp-gamma.stan")
get.script("ex1_exp-gamma_control_JAGS.R")
get.script("ex1_exp-gamma_control_STAN.R")
op.mf("exp-uniform.bug")
op.mf("exp-uniform.stan")
op.mf("exp-trunc-T.bug")
op.mf("exp-trunc-T.stan")

get_file("ex2_prior_plots.R")
get_file("norm-T.bug")
get_file("norm-T.stan")

get_file("ex2_norm-T_control_JAGS.R")
get_file("ex2_norm-T_control_STAN.R")

get_file("binomial-uniform.bug")
get_file("binomial-uniform.stan")

get_file("ex3_binomial-uniform_control_JAGS.R")
get_file("ex3_binomial-uniform_control_STAN.R")
get_file("binomial-uniform_multiple.bug")
get_file("binomial-uniform_multiple.stan")

get_file("ex3_binomial-uniform_multiple_control_JAGS.R")
get_file("ex3_binomial-uniform_multiple_control_STAN.R")

get_file("poisson-gamma.bug")
get_file("poisson-gamma.stan")
get_file("ex4a_poisson-gamma_control_JAGS.R")
get_file("ex4a_poisson-gamma_control_STAN.R")

get_file("poisson-gamma_multiple.bug")
get_file("poisson-gamma_multiple.stan")
get_file("ex4b_poisson-gamma_control_JAGS.R")
get_file("ex4b_poisson-gamma_control_STAN.R")

get_file("ex4c_poisson-gamma_control_JAGS.R")
get_file("ex4c_poisson-gamma_control_STAN.R")
