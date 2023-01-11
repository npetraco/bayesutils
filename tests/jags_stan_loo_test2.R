library(bayesutils)
library(loo)

# Extra options to set for Stan:
options(mc.cores = 1)
rstan_options(auto_write = TRUE)
# Load a Stan model:
stan.code   <- paste(readLines(system.file("stan/poisson-gamma_wloglik.stan", package = "bayesutils")),collapse='\n')
# Translate Stan code into C++
model.c <- stanc(model_code = stan.code, model_name = 'model', verbose=T)
# Compile the Stan C++ model:
sm <- stan_model(stanc_ret = model.c, verbose = T)

# Data
M <- c(1154, 1062, 1203, 1125, 1091, 1120, 1202, 1129, 1103, 1098, 1169, 1142, 1174, 1111, 1148,
       1134, 1146, 1179, 1165, 1076, 1152, 1209, 1205, 1139, 1227, 1145, 1140, 1220, 1059, 1165)
A <- c(1326, 1362, 1297, 1350, 1324, 1384, 1343, 1373, 1345, 1399, 1364, 1380, 1303, 1232, 1330,
       1306, 1309, 1336, 1367, 1291, 1325, 1348, 1318, 1351, 1382, 1340, 1305, 1306, 1333, 1337)
N <- c(1251, 1234, 1337, 1235, 1189, 1289, 1318, 1190, 1307, 1224, 1279, 1331, 1310, 1244, 1246,
       1168, 1267, 1274, 1262, 1254, 1139, 1236, 1310, 1227, 1310, 1255, 1230 ,1327, 1242, 1269)
s <- c(M,A,N)
dat   <- list(
  "n" = length(s),
  "s" = s,
  "a" = 25/16,
  "b" = 1/16000
)

# Fit Stan:
# Run the model:
fits <- sampling(sm, data = dat, iter=5000, thin = 1, chains = 4)
fits

# Fit JAGS
inits <- function (){
  list(lambda=runif(1))
}
fitj <- jags(data=dat,
            inits=inits,
            parameters.to.save = c("lambda", "log_lik"),
            n.iter=20000, n.burnin = 500, n.thin = 10,
            n.chains=4,
            model.file = system.file("jags/poisson-gamma_wloglik.bug.R", package = "bayesutils"))
fitj


# Extract log-likelihoods
# 3D array from Stan
log.lik.sa <- extract_log_lik(fits, merge_chains = FALSE)
class(log.lik.sa)
dim(log.lik.sa)
head(log.lik.sa)

# 2D matrix from Stan
log.lik.sm <- extract_log_lik(fits, merge_chains = TRUE)
class(log.lik.sm)
dim(log.lik.sm)
head(log.lik.sm)


# 3D array from JAGS
head(fitj$BUGSoutput$sims.array)
dimnames(fitj$BUGSoutput$sims.array)
log.lik.ja <- fitj$BUGSoutput$sims.array[,,3:92]
dim(log.lik.ja)

r.eff.ja   <- relative_eff(exp(log.lik.ja), cores = 2)
loo.est.ja <- loo(log.lik.ja, r_eff = r.eff.ja, cores = 2)
loo.est.ja

# 2D matrix from JAGS
head(fitj$BUGSoutput$sims.matrix)
dim(fitj$BUGSoutput$sims.matrix)
colnames(fitj$BUGSoutput$sims.matrix)

log.lik.jm <- fitj$BUGSoutput$sims.matrix[,3:92]
class(log.lik.jm)
dim(log.lik.jm)
head(log.lik.jm)

class(log.lik.sm)
dim(log.lik.sm)
head(log.lik.sm)


length(rep(1:4, each = 10000/4))
length(rep(1:4, each = nrow(log.lik.sm)/4))
r.eff.sm   <- relative_eff(exp(log.lik.sm), cores = 2, rep(1:4, each = nrow(log.lik.sm)/4))
loo.est.sm <- loo(log.lik.sm, r_eff = r.eff.sm, cores = 2)
loo.est.sm

r.eff.jm   <- relative_eff(exp(log.lik.jm), cores = 2, rep(1:4, each = nrow(log.lik.jm)/4))
loo.est.jm <- loo(log.lik.jm, r_eff = r.eff.jm, cores = 2)
loo.est.jm


log.lik.j2 <- extract.log.lik(fitj, parameter_name = "log_lik", merge_chains = T)
r.eff.j2   <- relative_eff(exp(log.lik.j2), cores = 2, rep(1:4, each = nrow(log.lik.j2)/4))
loo.est.j2 <- loo(log.lik.j2, r_eff = r.eff.j2, cores = 2)
loo.est.j2

log.lik.j2a <- extract.log.lik(fitj, parameter_name = "log_lik", merge_chains = F)
r.eff.j2a   <- relative_eff(exp(log.lik.j2a), cores = 2)
loo.est.j2a <- loo(log.lik.j2a, r_eff = r.eff.j2a, cores = 2)
loo.est.j2a
