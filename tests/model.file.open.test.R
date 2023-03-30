?View
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
