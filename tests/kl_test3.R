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


junk <- approx.KL.divergence(list(pri.mu.samp, params.mat$mu), num.points = 10000, renormalizeQ = T, plotQ=T)
junk$kl.div

dfi <- approx.density.func(pri.mu.samp,
                           num.points = 1000,
                           #bounds     = c(0,300),
                           #tol        = NULL,
                           tol        = 1e-6,
                           #eps        = .Machine$longdouble.neg.eps,
                           eps        = 2e-6,
                           printQ     = F,
                           plotQ      = T,
                           bre        = 40)
dfi$den.f(dfi$xax)



library(entropy)
library(flexmix)

dpri <- approx.density.func(pri.mu.samp, bounds = c(0,300), plotQ=T, bre=40)
dpst <- approx.density.func(params.mat$mu, bounds = c(0,300), plotQ=T)
x <- seq(from=0, to=300, length.out=1000)

KL.plugin(dpri$den.f(x), dpst$den.f(x))                          # entropy package

kli <- KLD(dpri$den.f(x), dpst$den.f(x))                         # LaplacesDemon package
kli$sum.KLD.px.py

KLdiv(cbind(dpri$den.f(x), dpst$den.f(x)), eps = 1e-19)          # flexmix package


KLD
px <- dpri$den.f(x)
py <- dpst$den.f(x)
px <- px/sum(px)
py <- py/sum(py)
sum(px * (log(px) - log(py)))
plot(px)
plot(py)



fqs <- get.bin.freqs(list(pri.mu.samp, params.mat$mu), num.bins = 40, countsQ=T)
KL.empirical(fqs[1,], fqs[2,])

KL.Dirichlet(fqs.cnts[1,], fqs.cnts[2,], a1=1, a2=1 )

discretize(pri.mu.samp, numBins=40)
