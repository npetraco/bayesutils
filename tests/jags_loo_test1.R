library(bayesutils)
library(loo)

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

inits <- function (){
  list(lambda=runif(1))
}

# Run the model:
fit <- jags(data=dat,
            inits=inits,
            parameters.to.save = c("lambda", "log.lik"),
            n.iter=20000, n.burnin = 500, n.thin = 10,
            n.chains=4,
            model.file = system.file("jags/poisson-gamma_wloglik.bug.R", package = "bayesutils"))
fit
                                                     # ****Difference here
params.mat <- extract.params(fit, as.matrixQ = T)    # Need a function to pull out log.lik values from JAGS fit.
colnames(params.mat)                                 # Merge it with extract_log_lik for a stan object
log.lik <- params.mat[,2:91]

dim(log.lik)

#r.eff   <- relative_eff(exp(log.lik), cores = 2, chain_id = rep(1:4, each = nrow(log.lik)/4 )) # ****Difference from stan here too
r.eff   <- relative_eff(exp(log.lik), cores = 2)
fit$BUGSoutput$sims.array
dim(fit$BUGSoutput$sims.array)
class(fit$BUGSoutput$sims.array)
fit$BUGSoutput$sims.array[,,]




dim(log.lik)


loo.est <- loo(as.matrix(log.lik), cores = 2)
loo.est

length(rep(1:4, each = nrow(log.lik)/4 ))
dim(exp(log.lik))
# 7800   90
nrow(exp(log.lik))

waic(as.matrix(log.lik))
