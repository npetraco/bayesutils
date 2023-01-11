library(bayesutils)

# Extra options to set for Stan:
options(mc.cores = 4)
rstan_options(auto_write = TRUE)
# Load a Stan model:
stan.code <- paste(readLines(system.file("stan/poi_test4.stan", package = "bayesutils")),collapse='\n')

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
  "offset"    = offset,
  "X"         = X,
  "y"         = stops
)

fit <- sampling(sm, data = dat, iter=100000, thin = 10, chains = 4)
fit
# beta[1]      -1.38    0.00 0.05     -1.48     -1.41     -1.38     -1.34     -1.28   969    1
# beta[2]       0.01    0.00 0.01      0.00      0.01      0.01      0.01      0.02 19249    1
# beta[3]      -0.42    0.00 0.01     -0.44     -0.43     -0.42     -0.41     -0.40 19555    1
# beta[4]      -0.15    0.00 0.07     -0.30     -0.20     -0.15     -0.10     -0.01  2043    1
# beta[5]       0.56    0.00 0.06      0.45      0.52      0.56      0.60      0.67  1199    1
# beta[6]       1.21    0.00 0.06      1.10      1.17      1.21      1.25      1.32  1209    1
# beta[7]       0.28    0.00 0.06      0.17      0.24      0.28      0.32      0.39  1202    1
# beta[8]       1.14    0.00 0.06      1.03      1.11      1.14      1.18      1.26  1195    1
# beta[9]       0.22    0.00 0.06      0.09      0.17      0.22      0.26      0.34  1507    1
# beta[10]     -0.39    0.00 0.06     -0.50     -0.43     -0.39     -0.35     -0.28  1172    1
# ....
#
#
fit.2 <- glm(formula = stops ~ factor(eth) + factor(precinct), offset = offset, family=poisson)
summary(fit.2)
# Estimate Std. Error z value Pr(>|z|)
# (Intercept)        -1.378868   0.051019 -27.027  < 2e-16 ***
# factor(eth)2        0.010188   0.006802   1.498 0.134190
# factor(eth)3       -0.419001   0.009435 -44.409  < 2e-16 ***
# factor(precinct)2  -0.149050   0.074030  -2.013 0.044077 *
# factor(precinct)3   0.559955   0.056758   9.866  < 2e-16 ***
# factor(precinct)4   1.210636   0.057549  21.037  < 2e-16 ***
# factor(precinct)5   0.282865   0.056794   4.981 6.34e-07 ***
# factor(precinct)6   1.144204   0.058047  19.712  < 2e-16 ***
# factor(precinct)7   0.218173   0.064335   3.391 0.000696 ***
# factor(precinct)8  -0.390565   0.056868  -6.868 6.51e-12 ***
# ....
