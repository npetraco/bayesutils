library(bayesutils)

# Extra options to set for Stan:
options(mc.cores = 1)
rstan_options(auto_write = TRUE)
# Load a Stan model:
stan.code <- paste(readLines(system.file("stan/poi_test2.stan", package = "bayesutils")),collapse='\n')

# Translate Stan code into C++
model.c <- stanc(model_code = stan.code, model_name = 'model', verbose=T)
# Compile the Stan C++ model:
sm <- stan_model(stanc_ret = model.c, verbose = T)

# Data
stops.dat <- aggregate(cbind(stops, past.arrests) ~ eth + precinct, data=frisk, sum)
N         <- nrow(stops.dat)
n_eth     <- 3
eth       <- stops.dat$eth
offeset   <- log(stops.dat$past.arrests)
stops     <- stops.dat$stops

dat   <- list(
  "N"       = N,
  "n_eth"   = n_eth,
  "eth"     = eth,
  "offeset" = offeset,
  "stops"   = stops
)

# Run the model:
fit <- sampling(sm, data = dat, iter=5000, thin = 1, chains = 4)
fit
-0.59
-0.52 - -0.59 #  0.07
-0.75 - -0.59 # -0.16

fit.2 <- glm(stops ~ factor(eth), data=stops.dat, family=poisson, offset=log(past.arrests))
summary(fit.2)


params.chains <- extract.params(fit, by.chainQ = T)
#mcmc_trace(params.chains, pars = c("alpha", "beta", "sigma"))
mcmc_pairs(params.chains, regex_pars = c("b_eth"))

# Examine posteriors:
params.mat <- extract.params(fit, as.matrixQ = T)
mcmc_areas(params.mat, prob = 0.95, regex_pars = c("b_eth"))


# Compute rates
colnames(params.mat)
beta1   <- params.mat$b_eth.1.
beta2   <- params.mat$b_eth.2.
beta3   <- params.mat$b_eth.3.
beta    <- cbind(beta1, beta2, beta3)
num.sim <- nrow(beta)

head(stops.dat)

#lambda[i] = offeset[i] + b_eth[eth[i]];
 hist(exp(offeset[1] + beta1)) # Rate for eth1 wrt total prior arrests at precint 1
 hist(exp(offeset[2] + beta1)) # Rate for eth1 wrt total prior arrests at precint 2
 hist(exp(offeset[3] + beta1)) # Rate for eth1 wrt total prior arrests at precint 3
 hist(exp(offeset[4] + beta1)) # Rate for eth1 wrt total prior arrests at precint 4
