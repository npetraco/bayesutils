#' XXXXX
#'
#' XXXXX
#'
#' The function is XXXXXXX
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @export
extract.params <- function(fit.obj, params.vec=NULL, by.chainQ=F, as.data.frameQ=F, as.matrixQ=F) {

  if(class(fit.obj) == "stanfit"){                                             # Stan

    if(by.chainQ==T){ # Organize by chain
      params.samples <- extract(fit.obj, inc_warmup = F, permuted = F)

    } else {          # Organize by merged sample

      if(is.null(params.vec)){
        # Get all the parameters if nothing is specified:
        params.vec.loc <- names(fit.obj)
        params.vec.loc <- params.vec.loc[-which(params.vec.loc == "lp__")]
      } else {
        params.vec.loc <- params.vec
      }
      params.samples <- extract(fit, params.vec.loc)

      if((as.data.frameQ==T) | (as.matrixQ==T)){
        pnms                     <- names(params.samples)
        params.samples           <- sapply(1:length(params.samples), function(xx){params.samples[[xx]]})
        colnames(params.samples) <- pnms
        params.samples           <- data.frame(params.samples) # Note if [] are in the names, which happens with vector and matrix parameters, the [] are changes to ..
        #print(colnames(params.samples))
      }

    }

  } else if(class(fit.obj) == "rjags"){                                        # JAGS

    # Do this in case no parameters were specified for an rjags fit.obj. Get all of them
    if(is.null(params.vec)) {
      #params.vec.loc <- fit.obj$parameters.to.save # Doesn't work for vector parameters
      params.vec.loc <- colnames(fit.obj$BUGSoutput$sims.matrix) # Do this instead incase some parameters are vectors or matrices
      params.vec.loc <- params.vec.loc[-which(params.vec.loc == "deviance")]
    } else {
      params.vec.loc <- params.vec
    }

    if(by.chainQ == T) { # Organize by chain. Us same format as spit out by rstan::extract

      jags.param.names.vec <- unlist(dimnames(fit.obj$BUGSoutput$sims.array))
      num.chains           <- fit.obj$BUGSoutput$n.chains
      sims.dims            <- dim(fit.obj$BUGSoutput$sims.array)
      params.samples       <- array(NA, c(sims.dims[1], num.chains, length(params.vec.loc)))
      dimnames(params.samples) <- list(
        iterations = NULL,
        chains     = paste0("chain:",1:num.chains),
        parameters = params.vec.loc
      )

      for(i in 1:length(params.vec.loc)){
        #print(paste0("Param #", i, " = ", params.vec.loc[i]))
        params.idx          <- which(jags.param.names.vec == params.vec.loc[i])
        params.samples[,,i] <- fit.obj$BUGSoutput$sims.array[,,params.idx]
      }

    } else {  # Organize by merged sample. Us same format as spit out by rstan::extract

      params.samples       <- rep(list(NULL), length(params.vec.loc))
      jags.param.names.vec <- colnames(fit.obj$BUGSoutput$sims.matrix)
      #print(jags.param.names.vec)
      for(i in 1:length(params.vec.loc)){
        #print(paste0("Param #", i, " = ", params.vec.loc[i]))
        params.idx          <- which(jags.param.names.vec == params.vec.loc[i])
        #print(params.idx)
        params.samples[[i]] <- fit.obj$BUGSoutput$sims.matrix[,params.idx]
      }
      names(params.samples) <- params.vec.loc

      if((as.data.frameQ==T) | (as.matrixQ==T)){
        pnms                     <- names(params.samples)
        #print(pnms)
        params.samples           <- sapply(1:length(params.samples), function(xx){params.samples[[xx]]})
        colnames(params.samples) <- pnms
        params.samples           <- data.frame(params.samples)
      }

    }

  } else {
    stop("fit.obj should be of class stanfit or rjags")
  }

  return(params.samples)

}


#' Function to extract log likelihoods form Stan or JAGS fit object
#'
#' Function to extract log likelihoods form Stan or JAGS fit object. Mirror functionality
#' of extract_log_lik in the loo package. Returns object suitable for use with loo package.
#'
#' The function is XXXXXXX
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @export
extract.log.lik <- function(fit.obj, parameter_name = "log_lik", merge_chains = F) {

  if(class(fit.obj) == "stanfit"){                                             # Stan

    log.lik.loc <- extract_log_lik(fit.obj, parameter_name = parameter_name, merge_chains = merge_chains)

  } else if(class(fit.obj) == "rjags") {

    if(merge_chains == F){
      param.names <- dimnames(fit.obj$BUGSoutput$sims.array)[[3]]
      log.lik.idxs <- which(grepl(parameter_name, param.names, fixed = TRUE) == T)
      if(length(log.lik.idxs) == 0) {
        stop(paste0("There is no parameter named: ",  parameter_name))
      } else {
        log.lik.loc <- fitj$BUGSoutput$sims.array[,,log.lik.idxs]
      }

    } else {
      param.names <- colnames(fit.obj$BUGSoutput$sims.matrix)
      log.lik.idxs <- which(grepl(parameter_name, param.names, fixed = TRUE) == T)
      if(length(log.lik.idxs) == 0) {
        stop(paste0("There is no parameter named: ",  parameter_name))
      } else {
        log.lik.loc <- fitj$BUGSoutput$sims.matrix[,log.lik.idxs]
      }
    }

  } else {
    stop("fit.obj should be of class stanfit or rjags")
  }

  return(log.lik.loc)

}
