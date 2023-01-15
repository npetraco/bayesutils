library(bayesutils)
library(bridgesampling)


### generate data ###
set.seed(12345)

mu <- 0
tau2 <- 0.5
sigma2 <- 1

n <- 20
theta <- rnorm(n, mu, sqrt(tau2))
y <- rnorm(n, theta, sqrt(sigma2))

### set prior parameters ###
mu0 <- 0
tau20 <- 1
alpha <- 1
beta <- 1

# H0: mu = 0
getSamplesModelH0 <- function(data, niter = 52000, nburnin = 2000, nchains = 3) {

  model <- "
    model {
      for (i in 1:n) {
        theta[i] ~ dnorm(0, invTau2)
          y[i] ~ dnorm(theta[i], 1/sigma2)
      }
      invTau2 ~ dgamma(alpha, beta)
      tau2 <- 1/invTau2
    }"

  s <- jags(data, parameters.to.save = c("theta", "invTau2"),
            model.file = textConnection(model),
            n.chains = nchains, n.iter = niter,
            n.burnin = nburnin, n.thin = 1)

  return(s)

}

# H1: mu != 0
getSamplesModelH1 <- function(data, niter = 52000, nburnin = 2000,
                              nchains = 3) {

  model <- "
    model {
      for (i in 1:n) {
        theta[i] ~ dnorm(mu, invTau2)
        y[i] ~ dnorm(theta[i], 1/sigma2)
      }
      mu ~ dnorm(mu0, 1/tau20)
      invTau2 ~ dgamma(alpha, beta)
      tau2 <- 1/invTau2
    }"

  s <- jags(data, parameters.to.save = c("theta", "mu", "invTau2"),
            model.file = textConnection(model),
            n.chains = nchains, n.iter = niter,
            n.burnin = nburnin, n.thin = 1)

  return(s)

}

# create data lists for JAGS
data_H0 <- list(y = y, n = length(y), alpha = alpha, beta = beta, sigma2 = sigma2)
data_H1 <- list(y = y, n = length(y), mu0 = mu0, tau20 = tau20, alpha = alpha, beta = beta, sigma2 = sigma2)

# fit models
samples_H0 <- getSamplesModelH0(data_H0)
samples_H1 <- getSamplesModelH1(data_H1)


### functions for evaluating the unnormalized posteriors on log scale ###

log_posterior_H0 <- function(samples.row, data) {

  mu <- 0
  invTau2 <- samples.row[[ "invTau2" ]]
  theta <- samples.row[ paste0("theta[", seq_along(data$y), "]") ]

  sum(dnorm(data$y, theta, data$sigma2, log = TRUE)) +
    sum(dnorm(theta, mu, 1/sqrt(invTau2), log = TRUE)) +
    dgamma(invTau2, data$alpha, data$beta, log = TRUE)

}
###############

data_H0
head(samples_H0$BUGSoutput$sims.matrix)
samples_H0$BUGSoutput$sims.matrix[1,]
log_posterior_H0(samples_H0$BUGSoutput$sims.matrix[2,], data_H0)



log_posterior_H0.test <- function(samples.row, data) {

  mu <- 0
  #invTau2 <- samples.row[[ "invTau2" ]]
  invTau2 <- samples.row[ "invTau2" ]
  theta <- samples.row[ paste0("theta[", seq_along(data$y), "]") ]
  # mu <- 0
  # invTau2 <- samples.row[2]
  # theta <- samples.row[ 3:22 ]


  #print(invTau2)
  #print(theta)
  #print(dnorm(data$y, theta, data$sigma2, log = TRUE))
  #print(dnorm(theta, mu, 1/sqrt(invTau2), log = TRUE))
  #print(dgamma(invTau2, data$alpha, data$beta, log = TRUE))
  #print(sum(dnorm(data$y, theta, data$sigma2, log = TRUE)))
  #print(sum(dnorm(theta, mu, 1/sqrt(invTau2), log = TRUE)))
  #print(dgamma(invTau2, data$alpha, data$beta, log = TRUE))


  sum(dnorm(data$y, theta, data$sigma2, log = TRUE)) +
    sum(dnorm(theta, mu, 1/sqrt(invTau2), log = TRUE)) +
    dgamma(invTau2, data$alpha, data$beta, log = TRUE)

}


log_posterior_H0.2 <- function(post.samp.vec, dat.in) {

  invTau2.loc <- post.samp.vec[2]
  theta.loc   <- post.samp.vec[3:22]
  y.loc       <- dat.in$y
  n.loc       <- dat.in$n
  alpha.loc   <- dat.in$alpha
  beta.loc    <- dat.in$beta
  sigma2.loc  <- dat.in$sigma2

  #print(invTau2.loc)
  #print(theta.loc)
  #print(dnorm(y.loc, mean = theta.loc, sd = sigma2.loc, log = T))
  #print(dnorm(theta.loc, mean = 0, sd = sqrt(1/invTau2.loc), log = T))
  #print(dgamma(invTau2.loc, alpha.loc, beta.loc, log = T))
  #print(sum(dnorm(y.loc, mean = theta.loc, sd = sigma2.loc, log = T)))
  #print(sum(dnorm(theta.loc, mean = 0, sd = sqrt(1/invTau2.loc), log = T)))
  #print(dgamma(invTau2.loc, alpha.loc, beta.loc, log = T))


  lp <- sum(dnorm(theta.loc, mean = 0, sd = sqrt(1/invTau2.loc), log = T)) +
        dgamma(invTau2.loc, alpha.loc, beta.loc, log = T) +
        sum(dnorm(y.loc, mean = theta.loc, sd = sigma2.loc, log = T))

  # sum(dnorm(data$y, theta, data$sigma2, log = TRUE)) +
  #   sum(dnorm(theta, mu, 1/sqrt(invTau2), log = TRUE)) +
  #   dgamma(invTau2, data$alpha, data$beta, log = TRUE)

  return(as.numeric(lp))

}

log_posterior_H0.test(samples_H0$BUGSoutput$sims.matrix[2,], data_H0)

log_posterior_H0.2(samples_H0$BUGSoutput$sims.matrix[2,], data_H0)




log_posterior_H1 <- function(samples.row, data) {

  mu <- samples.row[[ "mu" ]]
  invTau2 <- samples.row[[ "invTau2" ]]
  theta <- samples.row[ paste0("theta[", seq_along(data$y), "]") ]

  sum(dnorm(data$y, theta, data$sigma2, log = TRUE)) +
    sum(dnorm(theta, mu, 1/sqrt(invTau2), log = TRUE)) +
    dnorm(mu, data$mu0, sqrt(data$tau20), log = TRUE) +
    dgamma(invTau2, data$alpha, data$beta, log = TRUE)

}

log_posterior_H1.2 <- function(post.samp.vec, dat.in) {

  theta   <- post.samp.vec[4:23]
  mu      <- post.samp.vec[3]
  invTau2 <- post.samp.vec[2]
  y       <- dat.in$y
  sigma2  <- dat.in$sigma2
  mu0     <- dat.in$mu0
  tau20   <- dat.in$tau20
  alpha   <- dat.in$alpha
  beta    <- dat.in$beta

  lp <- sum(dnorm(theta, mu, 1/sqrt(invTau2), log = T)) + # vector
        sum(dnorm(y, theta, sigma2,  log = T)) +  #vector
        dnorm(mu, mu0, sqrt(tau20),  log = T) +
        dgamma(invTau2, alpha, beta, log = T)

  return(lp)
}


log_posterior_H1(samples_H1$BUGSoutput$sims.matrix[345,], data_H1)

log_posterior_H1.2(samples_H1$BUGSoutput$sims.matrix[345,], data_H1)


# psv <- samples_H1$BUGSoutput$sims.matrix[2,]
# ds  <- data_H1
# psv
# ds



# specify parameter bounds H0
cn <- colnames(samples_H0$BUGSoutput$sims.matrix)
cn
cn <- cn[cn != "deviance"]
cn
lb_H0 <- rep(-Inf, length(cn))
ub_H0 <- rep(Inf, length(cn))
names(lb_H0) <- cn
names(ub_H0) <- cn
lb_H0[[ "invTau2" ]] <- 0
lb_H0
ub_H0

# specify parameter bounds H1
cn <- colnames(samples_H1$BUGSoutput$sims.matrix)
cn <- cn[cn != "deviance"]
lb_H1 <- rep(-Inf, length(cn))
ub_H1 <- rep(Inf, length(cn))
names(lb_H1) <- names(ub_H1) <- cn
lb_H1[[ "invTau2" ]] <- 0
lb_H1
ub_H1

H0.bridge <- bridge_sampler(samples = samples_H0, data = data_H0,
                            log_posterior = log_posterior_H0, lb = lb_H0,
                            ub = ub_H0, silent = F)
H0.bridge


