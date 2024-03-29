library(bayesutils)

# Extra options to set for Stan:
options(mc.cores = 1)
rstan_options(auto_write = TRUE)
# Load a Stan model:
stan.code <- paste(readLines(system.file("stan/T-norm_T_multiple.stan", package = "bayesutils")),collapse='\n')

# Translate Stan code into C++
model.c <- stanc(model_code = stan.code, model_name = 'model', verbose=T)
# Compile the Stan C++ model:
sm <- stan_model(stanc_ret = model.c, verbose = T)


x.cs <- c(1.51131, 1.51838, 1.52315, 1.52247, 1.52365, 1.51613, 1.51602, 1.51623, 1.51719, 1.51683, 1.51545, 1.51556, 1.51727, 1.51531, 1.51609, 1.51508, 1.51653, 1.51514, 1.51658, 1.51617, 1.51732, 1.51645, 1.51831, 1.51640, 1.51623, 1.51685, 1.52065, 1.51651, 1.51711)
x.sp <- c(1.51905, 1.51937, 1.51829, 1.51852, 1.51299, 1.51888, 1.51916, 1.51969, 1.51115)
g.mn <- mean(c(x.cs, x.sp)) # Global mean
g.sd <- sd(c(x.cs, x.sp))   # Global sd
x.cs.std <- (x.cs - g.mn)/g.sd
x.sp.std <- (x.sp - g.mn)/g.sd

dat <- list(
  "n"           = length(x.sp.std),
  "y"           = x.sp.std,
  "nu_fix"      = 6,
  "mu_n_hyp"    = 0,
  "sigma_n_hyp" = 10,
  "nu_t_hyp"    = 3,
  "mu_t_hyp"    = 0,
  "sigma_t_hyp" = 1
)

# Run the model:
fit <- sampling(sm, data = dat, iter=5000, thin = 1, chains = 4)
print(fit)
plot(fit)
params.chains <- extract.params(fit, by.chainQ = T)
autocorrelation.plots(params.chains, pars = c("mu", "sigma"))

mcmc_trace(params.chains, pars = c("mu", "sigma"))
mcmc_pairs(params.chains, pars = c("mu", "sigma"))


# Examine posteriors:
params.mat <- extract.params(fit, as.matrixQ = T)
mcmc_areas(params.mat, prob = 0.95)

colnames(params.mat)
mu  <- params.mat[,"mu"]
mu2 <- g.mn + mu*g.sd
# Un-standardize:
hist(mu, bre=40)
hist(mu2, bre=40)
# Rescale to get rid of all the 1.5s, and put on a nicer looking scale
mu3 <- (mu2-1.5)*10000
parameter.intervals(mu3, plotQ = T)
(g.mn-1.5)*10000 # Empirical average for comparison
parameter.intervals(mu3, plotQ = T)
mean(mu2) # Actual posterior mean
