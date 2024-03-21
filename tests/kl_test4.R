library(bayesutils)
library(entropy)
library(flexmix)
library(LaplacesDemon)

pri.samp <- rnorm(1000, mean = 0, sd = 3)
pst.samp <- rnorm(1000, mean = 0, sd = 1)

hist(pri.samp, xlim-c(-10,10))
hist(pst.samp, xlim=c(-10,10))

dpri <- approx.density.func(pri.samp, bounds = c(-20,20), plotQ=T, bre=40)
dpst <- approx.density.func(pst.samp, bounds = c(-20,20), plotQ=T)
x    <- seq(from=-20, to=20, length.out=1000)

# Shrinking a gaussian down by a factor of 3 should be about 1-bit of information gain:
klib <- approx.KL.divergence(list(pst.samp, pri.samp), bounds = c(-20,20), plotQ=T, log.base = 2) # bayesutils
klib$kl.div

KL.plugin(dpst$den.f(x), dpri$den.f(x), unit = "log2")  # entropy package

kli <- KLD(dpst$den.f(x), dpri$den.f(x), base = 2)      # LaplacesDemon package
kli$sum.KLD.px.py

KLdiv(cbind(dpst$den.f(x), dpri$den.f(x)), eps = 1e-19) # flexmix package
log(exp(0.6888331), base = 2)

log(3, base = 2)


# kde1d package??
# kdensity package??
