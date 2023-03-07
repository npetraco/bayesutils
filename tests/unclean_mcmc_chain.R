library(bayesutils)

# Extra options to set for Stan:
options(mc.cores = 4)
rstan_options(auto_write = TRUE)

# Load a Stan model:
stan.code <- paste(readLines(system.file("stan/weibull_T_multiple.stan", package = "bayesutils")),collapse='\n')

# Translate Stan code into C++
model.c <- stanc(model_code = stan.code, model_name = 'model', verbose=T)

# Compile the Stan C++ model:
sm <- stan_model(stanc_ret = model.c, verbose = T)

# Data:
data("transactions")
transactions
dat.nf <- transactions[transactions$transaction.type == "not.fraud", 1]
dat.f  <- transactions[transactions$transaction.type == "fraud", 1]

X <- dat.f
#X <- dat.nf
hist(X)

dat <- list(
  "n"              = length(X),
  "y"              = X,
  #
  "sigma_nu_t_hyp"    = 3,
  "sigma_mu_t_hyp"    = 0,
  "sigma_sigma_t_hyp" = 10,
  #
  "alpha_nu_t_hyp"    = 3,
  "alpha_mu_t_hyp"    = 0,
  "alpha_sigma_t_hyp" = 10
)

# Run the model:
initf1 <- function() {
  list(alpha = 10, sigma = 1)
}


fit <- sampling(sm, data = dat, warmup = 13, init=initf1, iter=10000, thin = 1, chains = 4)
#fit <- sampling(sm, data = dat, iter=5000, thin = 1, chains = 4, control=list(adapt_delta=0.999))
fit
#pairs(fit)

params.mat <- extract.params(fit, by.chainQ = T)
head(params.mat)
ac <- params.mat[,,"alpha"]
dim(ac)
plot(ac[,1], typ="l")
acf(ac[,1])

samp <- ac[,1]
plot(samp, typ="l")
acf(samp)
hist(samp)

burn.in <- 500
thin    <- 15

# Toss first chunk of sample for out of equilibrium:
samp2   <- samp[(burn.in+1) : length(samp)]
plot(samp2, typ="l")
acf(samp2)
hist(samp2)


# Thin sample to de-correlate:
samp3  <- samp2[seq(1,length(samp2),thin)]
length(samp3)
plot(samp3, typ="l")
acf(samp3)
hist(samp3, bre=20)

clean.me.up.chain <- samp
write.csv(clean.me.up.chain, file = "data/clean.me.up.chain.csv", row.names = F)

clean.me.up.chain <- read.csv(file = "data/clean.me.up.chain.csv")
min(clean.me.up.chain)
max(clean.me.up.chain)

save(clean.me.up.chain, file="data/clean.me.up.chain.RData")


Rhat(as.matrix(clean.me.up.chain))
ess_bulk(as.matrix(clean.me.up.chain))
ess_tail(as.matrix(clean.me.up.chain))

Rhat(ac)
ess_bulk(ac)
ess_tail(ac)

dat <- read.csv("https://raw.githubusercontent.com/npetraco/bayesutils/master/data/clean.me.up.chain.csv", header=T)

