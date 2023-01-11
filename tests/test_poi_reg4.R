library(bayesutils)
library(dafs)
library(shinystan)

# Extra options to set for Stan:
options(mc.cores = 4)
rstan_options(auto_write = TRUE)
# Load a Stan model:
stan.code <- paste(readLines(system.file("stan/poi_test5.stan", package = "bayesutils")),collapse='\n')
#stan.code <- paste(readLines(system.file("stan/poi_test6.stan", package = "bayesutils")),collapse='\n')

# Translate Stan code into C++
model.c <- stanc(model_code = stan.code, model_name = 'model', verbose=T)
# Compile the Stan C++ model:
sm <- stan_model(stanc_ret = model.c, verbose = T)

# Data
data("wong.df")
count <- wong.df$Count
V     <- wong.df$V
H     <- wong.df$H
P     <- wong.df$P
X     <- model.matrix(~ V + H + P)
dim(X)

dat   <- list(
  "n"         = nrow(X),
  "p"         = ncol(X),
  "X"         = X,
  "y"         = count,
  "sig_beta"  = 10
)

fit <- sampling(sm, data = dat, iter=50000, thin = 10, chains = 4, control=list(max_treedepth=11))
#fit <- sampling(sm, data = dat, iter=6250, thin = 10, chains = 8, control=list(max_treedepth=15))
#fit <- sampling(sm, data = dat, iter=5000, thin = 1, chains = 4)
fit
launch_shinystan(fit)
#              mean se_mean   sd      2.5%       25%       50%       75%     97.5% n_eff Rhat
# beta[1]      4.47    0.00 0.02      4.44      4.46      4.47      4.48      4.50  9652    1
# beta[2]      0.00    0.00 0.00      0.00      0.00      0.00      0.00      0.00  9681    1
# beta[3]     -0.05    0.00 0.01     -0.06     -0.05     -0.05     -0.04     -0.04 10009    1
# beta[4]     -0.81    0.00 0.01     -0.82     -0.81     -0.81     -0.80     -0.79  9147    1
# beta[5]     -0.62    0.00 0.01     -0.64     -0.62     -0.62     -0.61     -0.59  9697    1
# Took about half hour for 50000 iters with 4 processes
# Took about 20 min for 50000 iters with 8 processes but have 1/3 the sample

fit2 <- glm(Count ~ V + H + P, data = wong.df, family = poisson)
summary(fit2)
#               Estimate Std. Error  z value Pr(>|z|)
# (Intercept)  4.467e+00  1.534e-02  291.281   <2e-16 ***
# V            3.878e-03  1.236e-05  313.844   <2e-16 ***
# HHRH40      -4.545e-02  5.251e-03   -8.656   <2e-16 ***
# HHRH55      -8.060e-01  6.102e-03 -132.098   <2e-16 ***
# PWC         -6.151e-01  1.029e-02  -59.753   <2e-16 ***


params.chains <- extract.params(fit, by.chainQ = T)
#mcmc_trace(params.chains, pars = c("alpha", "beta", "sigma"))
mcmc_pairs(params.chains, regex_pars = c("beta"))

# Examine posteriors:
params.mat <- extract.params(fit, as.matrixQ = T)
mcmc_areas(params.mat, prob = 0.95, regex_pars = c("beta"))

hist(params.mat$beta.2.)
