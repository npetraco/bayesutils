library(bayesutils)

# Extra options to set for Stan:
options(mc.cores = 4)
rstan_options(auto_write = TRUE)
# Load a Stan model:
stan.code <- paste(readLines(system.file("stan/poi_test5.stan", package = "bayesutils")),collapse='\n')

# Translate Stan code into C++
model.c <- stanc(model_code = stan.code, model_name = 'model', verbose=T)
# Compile the Stan C++ model:
sm <- stan_model(stanc_ret = model.c, verbose = T)

# Data
stops.dat <- aggregate(cbind(stops, past.arrests) ~ eth + precinct, data=frisk, sum)
stops     <- stops.dat$stops
eth       <- stops.dat$eth
precinct  <- stops.dat$precinct
offset    <- log(stops.dat$past.arrests)
X         <- model.matrix(~ factor(eth) + factor(precinct))
dim(X)

dat   <- list(
  "n"         = nrow(X),
  "p"         = ncol(X),
  "X"         = X,
  "y"         = stops,
  "sig_beta"  = 10
)

fit <- sampling(sm, data = dat, iter=50000, thin = 5, chains = 4)
fit
#               mean se_mean   sd      2.5%       25%       50%       75%     97.5% n_eff Rhat
# beta[1]       5.32    0.00 0.05      5.23      5.29      5.32      5.36      5.42   518    1
# beta[2]      -0.45    0.00 0.01     -0.46     -0.45     -0.45     -0.44     -0.44 16469    1
# beta[3]      -1.41    0.00 0.01     -1.43     -1.42     -1.41     -1.41     -1.40 16937    1
# beta[4]      -0.11    0.00 0.07     -0.25     -0.16     -0.11     -0.06      0.03  1134    1
# beta[5]       1.42    0.00 0.06      1.31      1.39      1.42      1.46      1.53   646    1
# beta[6]       1.29    0.00 0.06      1.18      1.26      1.29      1.33      1.40   645    1
# beta[7]       1.42    0.00 0.06      1.31      1.38      1.42      1.46      1.53   625    1
# beta[8]       1.21    0.00 0.06      1.10      1.17      1.21      1.25      1.32   677    1
# beta[9]       0.52    0.00 0.06      0.39      0.47      0.52      0.56      0.64   789    1
# beta[10]      1.40    0.00 0.06      1.29      1.36      1.40      1.44      1.51   640    1
# beta[11]     -0.31    0.00 0.08     -0.46     -0.36     -0.31     -0.25     -0.16  1192    1
# beta[12]      1.10    0.00 0.06      0.98      1.06      1.10      1.13      1.21   687    1
# ....
#
#
fit.2 <- glm(formula = stops ~ factor(eth) + factor(precinct), family=poisson)
summary(fit.2)
# Estimate Std. Error  z value Pr(>|z|)
# (Intercept)         5.320809   0.051031  104.267  < 2e-16 ***
# factor(eth)2       -0.447714   0.006061  -73.872  < 2e-16 ***
# factor(eth)3       -1.414281   0.008558 -165.263  < 2e-16 ***
# factor(precinct)2  -0.103919   0.074022   -1.404 0.160352
# factor(precinct)3   1.426389   0.056756   25.132  < 2e-16 ***
# factor(precinct)4   1.298811   0.057499   22.588  < 2e-16 ***
# factor(precinct)5   1.424516   0.056766   25.094  < 2e-16 ***
# factor(precinct)6   1.214566   0.058038   20.927  < 2e-16 ***
# factor(precinct)7   0.522189   0.064329    8.117 4.76e-16 ***
# factor(precinct)8   1.406861   0.056864   24.741  < 2e-16 ***
# factor(precinct)9  -0.300754   0.078142   -3.849 0.000119 ***
# factor(precinct)10  1.099478   0.058843   18.685  < 2e-16 ***
# ....

#params.chains <- extract.params(fit, by.chainQ = T)
#mcmc_trace(params.chains, pars = c("alpha", "beta", "sigma"))
#mcmc_pairs(params.chains, regex_pars = c("beta"))

# Examine posteriors:
params.mat <- extract.params(fit, as.matrixQ = T)
mcmc_areas(params.mat, prob = 0.95, regex_pars = c("beta"))


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
