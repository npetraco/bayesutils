library(bayesutils)

# Extra options to set for Stan:
options(mc.cores = 1)
rstan_options(auto_write = TRUE)

# Load a Stan model:
#working.dir <- setwd("Desktop/")
stan.code   <- paste(readLines("inst/stan_models/exp_inv-gamma_target_format.stan"),collapse='\n')

# Translate Stan code into C++
model.c <- stanc(model_code = stan.code, model_name = 'model')

# Compile the Stan C++ model:
sm <- stan_model(stanc_ret = model.c, verbose = T)

# Data:
fail.times <- c(0.2438356, 0.3917808, 4.7917808, 5.5561644, 0.2849315)
dat <- list(
  N     = length(fail.times),
  t     = fail.times,
  alpha = 1.5, # prior hyper-parameter
  beta  = 0.5  # prior hyper-parameter
)

#Run the model:
fit <- sampling(sm, data = dat, iter=5000, thin = 1, chains = 4)
print(fit)
traceplot(fit, pars=c("lambda"))
plot(fit)

# Examine the sampling output in more detail:
lambda <- extract(fit,"lambda")[[1]]
hist(lambda, bre=80, probability = T) # Posterior for p.heads

cred <- 0.95
alp  <- 1 - cred
quantile(lambda, prob = c(alp/2, 1-alp/2)) # Two-sided equal-tail PI
HPDI(lambda, cred)                         # HPDI


