library(bayesutils)
library(LaplacesDemon)

# Data:
x <- c(63.7697, 38.8534, 50.6481, 76.8564, 47.5911, 60.6131, 41.1518, 41.7563, 65.3300, 72.0342)
dat <- list(
  # The data:
  x         = x,
  n         = length(x),
  # Prior hyper-parameters:
  mu_nu_hyp  = 3,
  mu_mu_hyp  = 50,
  mu_sig_hyp = 20,
  #
  sigma_nu_hyp  = 3,
  sigma_mu_hyp  = 10,
  sigma_sig_hyp = 10
)

# Initalization:
inits <- function (){
  list(mu=10*runif(1), sigma=10*runif(1)) # per examiner
}

fit <- jags(data=dat,
            inits=inits,
            parameters.to.save = c("mu", "sigma"),
            n.iter=20000, n.burnin = 500, n.thin = 10,
            n.chains=4,
            model.file = get.mfp("norm-T_T.bug")) # per examiner
fit

params.mat <- extract.params(fit, as.matrixQ = T)


pri.mu.samp <- rst(10000, nu=3, mu=50, sigma=20)
pri.mu.samp <- pri.mu.samp[-which(pri.mu.samp < 0)]
hist(pri.mu.samp)
range(pri.mu.samp)

range(params.mat$mu)
hist(params.mat$mu)


# Need (constrained) range for prior and range for posterior sample
# flexmix for KL
approx.KL.divergence(list(pri.mu.samp, params.mat$mu))

approx.KL.divergence(list(pri.mu.samp, params.mat$mu), num.points = 10000, renormalizeQ = T, printQ=T)
approx.KL.divergence(list(pri.mu.samp, params.mat$mu), num.points = 10000, renormalizeQ = T, plotQ=T)

approx.KL.divergence(list(pri.mu.samp, params.mat$mu), num.points = 100, renormalizeQ = T,
                     printQ = F,
                     bounds = c(0,300),
                     tol    = 1e-21,
                     eps    = .Machine$longdouble.neg.eps,
                     subdivisions = 2000,
                     plotQ = T)

approx.KL.divergence(list(pri.mu.samp, params.mat$mu), bounds = c(0,300), num.points = 10000)
approx.KL.divergence(list(params.mat$mu, pri.mu.samp), bounds = c(0,300), num.points = 10000, subdivisions = 5000)

approx.KL.divergence(list(pri.mu.samp, pri.mu.samp), num.points = 10000, renormalizeQ = T)
approx.KL.divergence(list(params.mat$mu, params.mat$mu), bounds = c(0,300), num.points = 10000)

#tol
#eps
#base
#subdivisions
#plot

library(entropy)
fqs <- get.bin.freqs(list(pri.mu.samp, params.mat$mu), num.bins = 50)
fqs
KL.Dirichlet(fqs[1,], fqs[2,], a1=1, a2=1)

