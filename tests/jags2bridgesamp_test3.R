library(bayesutils)
library(bridgesampling)

log_posterior_H1 <- function(samples.row, data) {

  mu <- samples.row[[ "mu" ]]
  invTau2 <- samples.row[[ "invTau2" ]]
  theta <- samples.row[ paste0("theta[", seq_along(data$y), "]") ]

  sum(dnorm(data$y, theta, data$sigma2, log = TRUE)) +
    sum(dnorm(theta, mu, 1/sqrt(invTau2), log = TRUE)) +
    dnorm(mu, data$mu0, sqrt(data$tau20), log = TRUE) +
    dgamma(invTau2, data$alpha, data$beta, log = TRUE)

}

lp.h1 <- function(samples.row, data){     # ***** NOTE These MUST be the arguments for an log posterior function or bridgesampling throws an error

  mu      <- samples.row[ "mu" ]           # ***** NOTE Parameters MUST be input this way with their names from the JAGS calculation or bridge sampling will throw an error
  invTau2 <- samples.row[ "invTau2" ]
  theta   <- samples.row[ paste0("theta[", seq_along(data$y), "]") ]

  lp <- -1e-12
  for (i in 1:data$n) {
    lp <- lp + dnorm(theta[i], mu, 1/sqrt(invTau2), log = T)
    lp <- lp + dnorm(data$y[i], theta[i], data$sigma2, log = T)
  }
  #tau2 <- 1/invTau2
  lp <- lp + dnorm(mu, data$mu0, data$tau20, log = T)
  lp <- lp + dgamma(invTau2, data$alpha, data$beta, log = T)

  return(lp)

}

lp.h1.v2 <- function(samples.row, data){

  mu      <- samples.row[ "mu" ]
  invTau2 <- samples.row[ "invTau2" ]
  theta   <- samples.row[ paste0("theta[", seq_along(data$y), "]") ]

  lp <- sum( dnorm(theta, mu, 1/sqrt(invTau2), log = T) )
  lp <- lp + sum( dnorm(data$y, theta, data$sigma2, log = T) )

  #tau2 <- 1/invTau2
  lp <- lp + dnorm(mu, data$mu0, data$tau20, log = T)
  lp <- lp + dgamma(invTau2, data$alpha, data$beta, log = T)

  return(lp)

}


dim(samples_H1$BUGSoutput$sims.matrix)
pvt <- samples_H1$BUGSoutput$sims.matrix[sample(1:150000, size = 1),]
log_posterior_H1(pvt, data_H1)
lp.h1(pvt, data_H1)
lp.h1.v2(pvt, data_H1)

# specify parameter bounds H1
cn <- colnames(samples_H1$BUGSoutput$sims.matrix)
cn <- cn[cn != "deviance"]
lb_H1 <- rep(-Inf, length(cn))
ub_H1 <- rep(Inf, length(cn))
names(lb_H1) <- names(ub_H1) <- cn
lb_H1[[ "invTau2" ]] <- 0

class(lb_H1)

H1.bridge <- bridge_sampler(samples = samples_H1, data = data_H1,
                            log_posterior = log_posterior_H1,
                            lb = lb_H1, ub = ub_H1, silent = F)
H1.bridge

H1.bridge2 <- bridge_sampler(samples = samples_H1, data = data_H1,
                            log_posterior = lp.h1,
                            lb = lb_H1, ub = ub_H1, silent = F)
H1.bridge2

H1.bridge3 <- bridge_sampler(samples = samples_H1, data = data_H1,
                             log_posterior = lp.h1.v2,
                             lb = lb_H1, ub = ub_H1, silent = F)
H1.bridge3
