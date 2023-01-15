#' Set up paramerter bounds needed to use of JAGS output with bridgesampling library
#'
#' Set up paramerter bounds needed to use of JAGS output with bridgesampling library.
#' If parameter bounds are -Inf to Inf, no need to specify that. Just specify bounds aternative
#' to this in a list with element names equal to the parameters needing alternative bounds.
#'
#' The function is XXXXXXX
#'
#' @param param.info An rjags object or a vector of parameter names
#' @return The function will XX
#'
#'
#' @export
parameter.bounds <- function(param.info, params.alt.bounds.list=NULL) {

  if(class(param.info) == "rjags") {
    param.names <- colnames(param.info$BUGSoutput$sims.matrix)
  } else {
    param.names <- param.info
  }

  param.names.loc <- param.names[param.names != "deviance"]
  #print(param.names.loc)

  # Initialize all parameter bounds to lb = -Inf, ub = Inf
  lb.vec <- rep(-Inf, length(param.names.loc))
  ub.vec <- rep(Inf, length(param.names.loc))
  names(lb.vec) <- param.names.loc
  names(ub.vec) <- param.names.loc

  if(!is.null(params.alt.bounds.list)) {

    alt.bound.param.names <- names(params.alt.bounds.list)
    #print(alt.bound.param.names)

    for(i in 1:length(alt.bound.param.names)) {
      altpb.idxs <- which(grepl(alt.bound.param.names[i], param.names.loc, fixed = TRUE) == T)
      alt.bounds <- params.alt.bounds.list[[i]]

      lb.vec[altpb.idxs] <- alt.bounds[1]
      ub.vec[altpb.idxs] <- alt.bounds[2]

      #print(altpb.idxs)
      #print(params.alt.bounds.list[[i]])

    }

  }

  parameter.bounds.info        <- list(lb.vec, ub.vec)
  names(parameter.bounds.info) <- c("lb.vec", "ub.vec")

  return(parameter.bounds.info)

}


#' Un-normalized log posterior function corresponding to poisson-gamma.bug.R
#'
#' Un-normalized log posterior function corresponding to poisson-gamma.bug.R
#' This is just a port of the bugs model code to pure R. For use a log_posterior
#' arguement in bridge_sampling
#'
#'
#' The function is XXXXXXX
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @export
lpf.poisson.gamma <- function(sample.row, data){    # *****NOTE these MUST be the arguments

  # Extract parameter values:
  # *****NOTE these MUST be in this named format
  lambda <- sample.row[["lambda"]]
  #lambda <- sample.row[2]         # This format does not work :(

  # Initialize lp
  lp <- 1e-12

  # Priors
  lp <- lp + dgamma(lambda, data$a, data$b, log = T)

  # Likelihood and Log-likelihood
  for(i in 1:data$n){
    lp <- lp + dpois(data$s[i], lambda, log = T)
  }

  return(lp)

}

#' Vectorized un-normalized log posterior function corresponding to poisson-gamma.bug.R
#'
#' More vectorized version of un-normalized log posterior function corresponding to
#' poisson-gamma.bug.R This is just a port of the bugs model code to pure R. For
#' use a log_posterior argument in bridge_sampling.
#'
#'
#' The function is XXXXXXX
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @export
lpf.poisson.gamma2 <- function(sample.row, data){ # *****NOTE these MUST be the arguments

  # Extract parameter values:
  lambda <- sample.row[["lambda"]]       # *****NOTE these MUST be in this named format
  #lambda <- sample.row[2]         # This format does not work :(

  # Priors
  lp <- sum( dgamma(lambda, data$a, data$b, log = T) )

  # Likelihood
  lp <- lp + sum( dpois(data$s, lambda, log = T))

  return(lp)

}


#' Un-normalized log posterior function corresponding to poisson-gamma_multiple.bug.R
#'
#' Un-normalized log posterior function corresponding to poisson-gamma_multiple.bug.R
#' This is just a port of the bugs model code to pure R. For use a log_posterior
#' arguement in bridge_sampling
#'
#'
#' The function is XXXXXXX
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @export
lpf.poisson.gamma_multiple <- function(sample.row, data){    # *****NOTE these MUST be the arguments

  # Extract parameter values:
  # *****NOTE parameters MUST be input in this named format. Names must be the same as used in the JAGS calculation
  lambda <- sample.row[ paste0("lambda[", 1:data$m, "]") ]

  # Initialize lp
  lp <- 1e-12

  # Priors
  for(j in 1:data$m){
    lp <- lp + dgamma(lambda[j], data$a, data$b, log = T)
  }

  # Likelihood and Log-likelihood
  for(j in 1:data$m){
    for(i in 1:data$n){
      lp <- lp + dpois(data$s[i,j], lambda[j], log = T)
    }
  }

  return(lp)
}


#' Vectorized un-normalized log posterior function corresponding to poisson-gamma_multiple.bug.R
#'
#' More vectorized version of un-normalized log posterior function corresponding to
#' poisson-gamma_multiple.bug.R This is just a port of the bugs model code to pure R. For
#' use a log_posterior argument in bridge_sampling.
#'
#'
#' The function is XXXXXXX
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @export
lpf.poisson.gamma_multiple2 <- function(sample.row, data){    # *****NOTE these MUST be the arguments

  # Extract parameter values:
  # *****NOTE these MUST be in this named format
  lambda <- sample.row[ paste0("lambda[", 1:data$m, "]") ]

  # Priors
  lp <- sum( dgamma(lambda, data$a, data$b, log = T) )

  # Likelihood
  for(i in 1:data$m) {
    lp <- lp + sum( dpois(data$s[,i], lambda[i], log = T))
  }

  return(lp)

}
