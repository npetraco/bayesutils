library(bayesutils)

# Extra options to set for Stan:
options(mc.cores = 4)
rstan_options(auto_write = TRUE)
# Load a Stan model:
stan.code <- paste(readLines(system.file("stan/poi_test3.stan", package = "bayesutils")),collapse='\n')

# Translate Stan code into C++
model.c <- stanc(model_code = stan.code, model_name = 'model', verbose=T)
# Compile the Stan C++ model:
sm <- stan_model(stanc_ret = model.c, verbose = T)

# Data
stops.dat <- aggregate(cbind(stops, past.arrests) ~ eth + precinct, data=frisk, sum)

N         <- nrow(stops.dat)
n_eth     <- 3
n_precint <- 75
eth       <- stops.dat$eth
precint  <- stops.dat$precinct
offeset   <- log(stops.dat$past.arrests)
stops     <- stops.dat$stops

dat   <- list(
  "N"         = N,
  "n_eth"     = n_eth,
  "n_precint" = n_precint,
  "eth"       = eth,
  "precint"   = precint,
  "offeset"   = offeset,
  "stops"     = stops
)

# Run the model:
fit <- sampling(sm, data = dat, iter=500000, thin = 20, chains = 4, control=list(max_treedepth=20))
fit # Not converging.....

fit.2 <- glm(formula = stops ~ factor(eth) + factor(precint), family=poisson, offset=offeset)
summary(fit.2)
