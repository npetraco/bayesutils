library(bayesutils)

# Data:
fail.times <- c(0.2438356, 0.3917808, 4.7917808, 5.5561644, 0.2849315)
dat <- list(
  N     = length(fail.times),
  t     = fail.times,
  alpha = 1.5, # prior hyper-parameter
  beta  = 0.5  # prior hyper-parameter
)


# Run the model
jags.inits <- function() {
  list(
    tau = 1/runif(1, 0.01, 5)
  )
}

params <- c("lambda")

fit <- jags(data = dat, #inits = init,
            parameters.to.save = model_parameters,
            model.file = "inst/jags_models/exp_inv-gamma.bug.R",
            inits = jags.inits,
            n.chains = 4,
            n.iter = 10000,
            n.burnin = 1000,
            n.thin = 10)
fit
plot(fit)
lambda <- fit$BUGSoutput$sims.matrix[,"lambda"]
R2jags::traceplot(fit)

hist(lambda, bre=80, probability = T) # Posterior for p.heads

cred <- 0.95
alp  <- 1 - cred
quantile(lambda, prob = c(alp/2, 1-alp/2)) # Two-sided equal-tail PI
HPDI(lambda, cred)                         # HPDI
