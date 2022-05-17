# Experimental stripped dowm port of dnest python function postprocess in classic.py
process.dnest.info <- function(sample.info.mat, level.info.mat) {

  # logLs AND tiebreakers level cutoffs
  logL.levels <- level.info.mat[,c(2,3)]

  # logLs AND tiebreakers sampled
  logL.samples <- sample.info.mat[,c(2,3)]

  # Find sandwiching level for each sample
  #Tnitalize with assigned levels (how were these assigned??):
  sandwch <- sample.info.mat[,1]
  # **Not sure if I ported this correctly. Clever python code
  # Also, it is slow...
  for(i in 1:nrow(sample.info.mat)) {
    while((sandwch[i] < nrow(level.info) - 1) & (logL.samples[i,1] > (logL.levels[sandwch[i] + 2,1])) ) {
      sandwch[i] <- sandwch[i] + 1
    }
  }

  # Loop over levels and assign logX to each sampled logL
  # Level numbering starts from 0:
  max.level <- (nrow(level.info) - 1)
  augmented.sample.info.mat <- NULL    # Dumb, but good enough for now.
  for(lev in 0:max.level) {

    lev.idxs <- which(sandwch==lev)
    lev.leng <- length(lev.idxs)       # N in python code

    logX.max <- level.info.mat[lev+1,1]
    if(lev == max.level) {
      logX.min <- -1e300 # for TOP LEVEL, i.e. log(0)
    } else {
      logX.min <- level.info[lev+2,1]
    }
    #print(paste("Level:", lev, "max logX:", logX.max, " min logX", logX.min))

    # Umin in python code
    dXmin <- exp(logX.min - logX.max)
    # Random X values. U in python code
    X.rand <- dXmin + (1 - dXmin) * runif(lev.leng, 0, 1)
    # Equally spaced X values. I think these are the default in the python. CHECK
    X.eqsp <- dXmin + (1 - dXmin) * seq(from=(1/(lev.leng+1)), to=(1 - 1/(lev.leng+1)), length.out = lev.leng)

    logX.samples.thisLevel.rand <- sort(logX.max + log(X.rand), decreasing = T)
    logX.samples.thisLevel.eqsp <- sort(logX.max + log(X.eqsp), decreasing = T)

    # Tack level cutoffs into the logX data returned:
    # NOTE: these should be in decreasing order
    logX.samples.thisLevel.rand <- c(level.info.mat[lev+1,1], logX.samples.thisLevel.rand)   # for TOP level
    logX.samples.thisLevel.eqsp <- c(level.info.mat[lev+1,1], logX.samples.thisLevel.eqsp) # for TOP level


    # logLs AND tiebreakers for level:
    logL.samples.thisLevel <- sample.info[lev.idxs, c(2,3)]

    # Reshuffle to be in XXXX(increasing????)XXXX order
    shuffle.idxs <- order(logL.samples.thisLevel[,1])
    logL.samples.thisLevel <- logL.samples.thisLevel[shuffle.idxs,]
    #print(paste("Level", lev))
    #print(logL.samples.thisLevel)

    # Tack level cutoffs into the logL data returned:
    # NOTE: these should be in increasing order
    #print(paste("Level", lev))
    #print(dim(logL.samples.thisLevel))
    # Annoying work around for a naming exception that R is throwing...
    cut.off.row <- level.info.mat[lev+1,c(2,3)]
    names(cut.off.row) <- names(logL.samples.thisLevel)
    logL.samples.thisLevel <- rbind(cut.off.row, logL.samples.thisLevel)
    #print(dim(logL.samples.thisLevel))
    #print(cut.off.row)

    #print(dim(logL.samples.thisLevel))
    #print(length(logX.samples.thisLevel.rand))
    #print(length(logX.samples.thisLevel.eqsp))
    samples.thisLevel <- cbind(logX.samples.thisLevel.eqsp, logX.samples.thisLevel.rand, logL.samples.thisLevel)
    #print(dim(samples.thisLevel))
    augmented.sample.info.mat <- rbind(augmented.sample.info.mat, samples.thisLevel)
  }
  colnames(augmented.sample.info.mat) <- c("logX.eqsp", "logX.rand", "logL")

  # Compute (log) mass intervals
  leng.dX         <- nrow(augmented.sample.info.mat)-1
  logdX.eqsp      <- array(NaN, leng.dX)
  logdX.rand      <- array(NaN, leng.dX)
  logdX.eqsp.trap <- array(NaN, leng.dX-2)
  logdX.rand.trap <- array(NaN, leng.dX-2)
  for(i in 2:leng.dX){
    # Using dX = X_{i-1} - X_i
    logdX.eqsp[i-1] <- logdiffexp(logdX.eqsp[i-1], logdX.eqsp[i])
    logdX.rand[i-1] <- logdiffexp(logdX.rand[i-1], logdX.rand[i])
    # For trapazoid dX = (X_{i-1} - X_{i+1})/2:
    if(i < (leng.dX-1)) {
      logdX.eqsp.trap[i-1] <- log(0.5) + logdiffexp(logdX.eqsp[i-1], logdX.eqsp[i+1])
      logdX.rand.trap[i-1] <- log(0.5) + logdiffexp(logdX.rand[i-1], logdX.rand[i+1])
    }
  }

  # Not necessary. FIX LATER
  logL <- augmented.sample.info.mat[,3]
  logZ <- -1e300
  for(i in 1:(length(logL)-1)) {
    print(i)
    logZ <- logsumexp(logZ, logL[i] + logdX.eqsp[i])
  }
  print(logZ)



  return(augmented.sample.info.mat)

}

