ns.diagnostic.plots <- function(nest.samp.info, likf=NULL, param1=NULL, param2=NULL) {

  logLiks      <- nest.samp.info$logLstars                                      # logL* WITHOUT the last live set
  num.itrs     <- length(logLiks)                                               # number of ns iterations used to reach tol
  prior.sze    <- nrow(nest.samp.info$posterior) - num.itrs                     # size of the live set
  logdXm       <- nest.samp.info$log.widths                                     # log prior mass increments
  Xm           <- exp(-(0:num.itrs)/prior.sze)                                  # approx prior masses covered by above above logL*
  logWgt       <- nest.samp.info$log.weight                                     # logWt = log(L dX) BUT extended with weights for last live set
  logdXm.last  <- -num.itrs/prior.sze - log(prior.sze)                          # log Remaining prior vol with respect to last live set
  logLiks.last <- nest.samp.info$posterior[(num.itrs+1):(num.itrs+prior.sze),2] # log Likelihoods of the last live set
  logWgt.last  <- logdXm.last + logLiks.last                                     # log Wts for last live set

  logLikstars  <- c(-Inf, logLiks, logLiks.last)                                # ALL logL* inclucing those from the live set
  Xmstars      <- c(Xm, Xm[num.itrs] - (1:prior.sze) * exp(logdXm.last))        # Corresponding X (I think....)
  Zc           <- exp(nest.samp.info$logevidence)                               # marginal likelihood


  split.screen( figs = c( 2, 2 ) )

  # 1. Likelihood contour plot:
  if(!is.null(likf)) {
    liks.mat <- outer(param1, param2, likf)
    screen(1)
    plot(0, 0, type = "n", xlim = c(min(param1), max(param1)), ylim = c(min(param2), max(param2)), xlab = "", ylab = "")
    contour(param1, param2, liks.mat, levels=c(seq(0.001,0.01,0.001),seq(0.01,0.14,0.01)))
  }

  # 2. X vs L* init plot:
  screen(2)
  plot(0,0, xlim=c(0,1), typ="n", ylim=c(0,max(exp(logLiks))), xlab="X", ylab="L*")

  # 3. inc vs accumulating Z init plot:
  screen(3)
  plot(0,0, ylim=c(0,Zc), typ="n", xlim=c(0,num.itrs+prior.sze), xlab="increment", ylab="Z accum")

  # 4. inc vs log weight (log(Li wi)) init plot:
  screen(4)
  plot(0,0, xlim=c(0,num.itrs+prior.sze), typ="n", ylim=c(min(logWgt), max(logWgt)), xlab="increment", ylab="log(Wt)")

  # Fill in plots
  param1.star <- ns.results$posterior[,3] # parameter 1 of the live set (also the posterior)
  param2.star <- ns.results$posterior[,4] # parameter 2 of the live set (also the posterior)
  log.Zc <- -2.2e308
  for(i in 1:(num.itrs+prior.sze)) {

    if(i <= num.itrs) {
      colr <- "blue"  # for the iterations
    } else {
      colr <- "green" # for the last live set
    }

    # 1.
    screen(1)
    points(param1.star[i], param2.star[i], pch=16, col=colr)

    # 2.
    screen(2)
    points(Xmstars[i], exp(logLikstars[i]), pch=16, col=colr)

    # 3.
    log.Zc <- logsumexp(log.Zc, logWgt[i])
    screen(3)
    points(i, exp(log.Zc), xlab="increment", ylab="Z accum", col=colr)
    if(i == (num.itrs+prior.sze)) {
      abline(Zc,0)
    }

    # 4.
    screen(4)
    points(i, logWgt[i], xlab="increment", ylab="log(Wt)", col=colr)

    print(paste0(i, " Prior mass covered by logL > ", round(logLikstars[i],3), " is X = exp(", round(log(Xmstars[i]),3), ")", " log(Z) = ", round(log.Zc, 3)))
    #print(paste0(i, " Prior mass covered by logL > ", logLstars[i], " is X = ", Xstars[i], " log(Z) = ", log.Z))
    Sys.sleep(0.1)
  }

}


#-----------------------------------
# Separate window
#-----------------------------------
ns.diagnostic.plots2 <- function(nest.samp.info, likf=NULL, param1=NULL, param2=NULL, screen.nums=NULL, initial.delay=0.0) {

  if(is.null(screen.nums)){
    stop("Turn on 3-4 graphics devices and set screen numbers!")
  }

  logLiks      <- nest.samp.info$logLstars                                      # logL* WITHOUT the last live set
  num.itrs     <- length(logLiks)                                               # number of ns iterations used to reach tol
  prior.sze    <- nrow(nest.samp.info$posterior) - num.itrs                     # size of the live set
  logdXm       <- nest.samp.info$log.widths                                     # log prior mass increments
  Xm           <- exp(-(0:num.itrs)/prior.sze)                                  # approx prior masses covered by above above logL*
  logWgt       <- nest.samp.info$log.weight                                     # logWt = log(L dX) BUT extended with weights for last live set
  logdXm.last  <- -num.itrs/prior.sze - log(prior.sze)                          # log Remaining prior vol with respect to last live set
  logLiks.last <- nest.samp.info$posterior[(num.itrs+1):(num.itrs+prior.sze),2] # log Likelihoods of the last live set
  logWgt.last  <- logdXm.last + logLiks.last                                     # log Wts for last live set

  logLikstars  <- c(-Inf, logLiks, logLiks.last)                                # ALL logL* inclucing those from the live set
  Xmstars      <- c(Xm, Xm[num.itrs] - (1:prior.sze) * exp(logdXm.last))        # Corresponding X (I think....)
  Zc           <- exp(nest.samp.info$logevidence)                               # marginal likelihood


  #split.screen( figs = c( 2, 2 ) )

  # 1. Likelihood contour plot:
  if(!is.null(likf)) {
    liks.mat <- outer(param1, param2, likf)
    dev.set(which = dev.list()[screen.nums[1]])
    plot(0, 0, type = "n", xlim = c(min(param1), max(param1)), ylim = c(min(param2), max(param2)), xlab = "", ylab = "")
    contour(param1, param2, liks.mat, levels=c(seq(0.001,0.01,0.001),seq(0.01,0.14,0.01)))
  }

  # 2. X vs L* init plot:
  dev.set(which = dev.list()[screen.nums[2]])
  plot(0,0, xlim=c(0,1), typ="n", ylim=c(0,max(exp(logLiks))), xlab="X", ylab="L*")

  # 3. inc vs accumulating Z init plot:
  dev.set(which = dev.list()[screen.nums[3]])
  plot(0,0, ylim=c(0,Zc), typ="n", xlim=c(0,num.itrs+prior.sze), xlab="increment", ylab="Z accum")

  # 4. inc vs log weight (log(Li wi)) init plot:
  dev.set(which = dev.list()[screen.nums[4]])
  plot(0,0, xlim=c(0,num.itrs+prior.sze), typ="n", ylim=c(min(logWgt), max(logWgt)), xlab="increment", ylab="log(Wt)")

  Sys.sleep(initial.delay)

  # Fill in plots
  param1.star <- ns.results$posterior[,3] # parameter 1 of the live set (also the posterior)
  param2.star <- ns.results$posterior[,4] # parameter 2 of the live set (also the posterior)
  log.Zc <- -2.2e308
  for(i in 1:(num.itrs+prior.sze)) {

    if(i <= num.itrs) {
      colr <- "blue"  # for the iterations
    } else {
      colr <- "green" # for the last live set
    }

    # 1.
    dev.set(which = dev.list()[screen.nums[1]])
    points(param1.star[i], param2.star[i], pch=16, col=colr)

    # 2.
    dev.set(which = dev.list()[screen.nums[2]])
    points(Xmstars[i], exp(logLikstars[i]), pch=16, col=colr)

    # 3.
    log.Zc <- logsumexp(log.Zc, logWgt[i])
    dev.set(which = dev.list()[screen.nums[3]])
    points(i, exp(log.Zc), xlab="increment", ylab="Z accum", col=colr)
    if(i == (num.itrs+prior.sze)) {
      abline(Zc,0)
    }

    # 4.
    dev.set(which = dev.list()[screen.nums[4]])
    points(i, logWgt[i], xlab="increment", ylab="log(Wt)", col=colr)

    print(paste0(i, " Prior mass covered by logL > ", round(logLikstars[i],3), " is X = exp(", round(log(Xmstars[i]),3), ")", " log(Z) = ", round(log.Zc, 3)))
    #print(paste0(i, " Prior mass covered by logL > ", logLstars[i], " is X = ", Xstars[i], " log(Z) = ", log.Z))
    Sys.sleep(0.1)
  }

}
