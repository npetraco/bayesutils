library(bayesutils)
library(kde1d)
# kde1d package??
# kdensity package??

library(entropy)
library(flexmix)
library(LaplacesDemon)

pri.samp <- rnorm(1000, mean = 0, sd = 3)
pst.samp <- rnorm(1000, mean = 0, sd = 1)

hist(pri.samp, xlim=c(-10,20))
hist(pst.samp, xlim=c(-10,20))

fit.pri <- kde1d(pri.samp)
fit.pst <- kde1d(pst.samp)
plot(fit.pri)
plot(fit.pst)

axx     <- seq(from=-10, to=20, length.out=1000)
ayy.pri <- dkde1d(axx, fit.pri)
ayy.pst <- dkde1d(axx, fit.pst)

# ayy.pri[which(ayy.pri <= .Machine$longdouble.eps)] <- .Machine$longdouble.eps
# ayy.pst[which(ayy.pst <= .Machine$longdouble.eps)] <- .Machine$longdouble.eps
ayy.pri[which(ayy.pri <= .Machine$double.xmin)] <- .Machine$double.xmin
ayy.pst[which(ayy.pst <= .Machine$double.xmin)] <- .Machine$double.xmin


cts.pri <- discretize(pri.samp, numBins = 40, r=c(-10,20))
cts.pst <- discretize(pst.samp, numBins = 40, r=c(-10,20))

KL.plugin(ayy.pst, ayy.pri, unit = "log2")  # entropy package
kli <- KLD(ayy.pst, ayy.pri, base = 2)      # LaplacesDemon package
kli$sum.KLD.px.py
KLdiv(cbind(ayy.pst, ayy.pri), eps = .Machine$double.xmin) # flexmix package
log(exp(0.604062), base = 2)

dpri <- approx.density.func(pri.samp, bounds = c(-10,20), plotQ=T, bre=40)
dpst <- approx.density.func(pst.samp, bounds = c(-10,20), plotQ=T)
klib <- approx.KL.divergence(list(pst.samp, pri.samp), bounds = c(-10,20), plotQ=T, tol = .Machine$double.xmin, eps =.Machine$double.xmin, log.base = 2) # bayesutils
klib$kl.div


KL.plugin(ayy.pst, dnorm(axx, mean = 0, sd = 3), unit = "log2")
KL.Dirichlet(cts.pst, cts.pri, a1=1, a2=1, unit = "log2" )
KL.shrink(cts.pst, cts.pri, unit = "log2")

