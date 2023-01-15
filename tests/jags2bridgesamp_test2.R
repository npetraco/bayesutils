log_posterior_H0 <- function(samples.row, data) {

  mu <- 0
  invTau2 <- samples.row[[ "invTau2" ]]
  theta <- samples.row[ paste0("theta[", seq_along(data$y), "]") ]

  sum(dnorm(data$y, theta, data$sigma2, log = TRUE)) +
    sum(dnorm(theta, mu, 1/sqrt(invTau2), log = TRUE)) +
    dgamma(invTau2, data$alpha, data$beta, log = TRUE)

}

lp.ho <- function(samples.row, data) {

  mu <- 0
  invTau2 <- samples.row[ "invTau2" ]
  theta <- samples.row[ paste0("theta[", seq_along(data$y), "]") ]

  lp <- -1e-12
  for (i in 1:data$n) {
    lp <- lp + dnorm(theta[i], mu, 1/sqrt(invTau2), log = T)
    lp <- lp + dnorm(data$y[i], theta[i], data$sigma2, log = T)
  }
  lp <- lp + dgamma(invTau2, data$alpha, data$beta, log = T)

  return(lp)

}

lp.ho.v2 <- function(samples.row, data) {

  mu <- 0
  invTau2 <- samples.row[ "invTau2" ]
  theta <- samples.row[ paste0("theta[", seq_along(data$y), "]") ]

  lp <- sum( dnorm(theta, mu, 1/sqrt(invTau2), log = T) )
  lp <- lp + sum( dnorm(data$y, theta, data$sigma2, log = T) )
  lp <- lp + dgamma(invTau2, data$alpha, data$beta, log = T)

  return(lp)

}

# specify parameter bounds H0
cn <- colnames(samples_H0$BUGSoutput$sims.matrix)
cn <- cn[cn != "deviance"]
lb_H0 <- rep(-Inf, length(cn))
ub_H0 <- rep(Inf, length(cn))
names(lb_H0) <- names(ub_H0) <- cn
lb_H0[[ "invTau2" ]] <- 0


tpv0 <- samples_H0$BUGSoutput$sims.matrix[1,]
data_H0
lp.ho(tpv0, data_H0)
log_posterior_H0(tpv0, data_H0)
lp.ho.v2(tpv0, data_H0)

H0.bridge <- bridge_sampler(samples = samples_H0, data = data_H0,
                            log_posterior = log_posterior_H0, lb = lb_H0,
                            ub = ub_H0, silent = F)
H0.bridge

H0.bridge <- bridge_sampler(samples = samples_H0, data = data_H0,
                            log_posterior = lp.ho, lb = lb_H0,
                            ub = ub_H0, silent = F)
H0.bridge

H0.bridge <- bridge_sampler(samples = samples_H0, data = data_H0,
                            log_posterior = lp.ho.v2, lb = lb_H0,
                            ub = ub_H0, silent = F)
H0.bridge

#-37.53183
#-37.53077

#-37.53169
#-37.53135
