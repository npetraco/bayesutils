# For a stanfit object
stm  <- extract.params(fit, params.vec = c("mu", "sigma"))
stm2 <- extract.params(fit, params.vec = c("mu", "sigma"), by.chainQ = F)
stc  <- extract.params(fit, by.chainQ = T)

# For an rjags object
jtm  <- extract.params(fit2, params.vec = c("mu", "sigma"))
jtm2 <- extract.params(fit2, params.vec = c("mu", "sigma"), by.chainQ = F)
jtc  <- extract.params(fit2, params.vec = c("mu", "sigma"), by.chainQ = T)
jtc2 <- extract.params(fit2, by.chainQ = T)

mcmc_trace(jtc2, pars = c("mu", "sigma"))
mcmc_trace(jtc2, pars = c("mu"))
mcmc_trace(stc, pars = c("mu"))

hist(stm$mu)
hist(jtm$mu)

mean(stm$mu)
mean(jtm$mu)
