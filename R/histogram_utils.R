#' The function to bin and get frequencies for data
#'
#' Handy for use with discrete entropy and related functions
#'
#' @param dat.list The data. Send data in as a list in case data vectors are not the same length
#' @param num.bin  How many bins to use
#' @param countsQ  Return bin counts instead of frequencies
#' @return The function will XX
#'
#'
#' @export
get.bin.freqs <- function(dat.list, num.bins, countsQ=F) {

  all.dat.loc <- unlist(dat.list)
  dbrks       <- seq(from=min(all.dat.loc), to=max(all.dat.loc), length.out=(num.bins+1))
  #print(dbrks)

  freq.mat <- NULL
  for(i in 1:length(dat.list)) {

    dcnts  <- table(cut(dat.list[[i]], breaks = dbrks, include.lowest = T ))
    dfreqs <- dcnts/sum(dcnts)
    #print(dfreqs)

    if(countsQ == T) {
      freq.mat <- rbind(freq.mat, dcnts)
    } else {
      freq.mat <- rbind(freq.mat, dfreqs)
    }

  }

  return(freq.mat)
}


#' Function to roughly estimate Kullback-Leibler divergence between two distribution samples
#'
#' Function to roughly estimate Kullback-Leibler divergence between two distribution samples
#'
#' @param dat.list     Samples from two distributions. Send in as a list in case samples are not the same length
#' @param bounds       Left and right bounds on distributions. If NULL, min/max of samples used
#' @param num.points   Length of common support domain (x-axis) to be used for both distributions
#' @param bw           Bandwidth to be used for density fits. Cf. density()
#' @param log.base     Log base to be used in KL formula
#' @param renormalizeQ Whether or not to re-normalize density fits so that they are normalized over the specified bounds
#' @param tol          Minimum fit density value. Below tol, density values will be replaced with eps
#' @param eps          Replacement density value for densities below tol
#' @param subdivisions Maximum number of subintervals for integrate()
#' @param plotQ        Plot flag
#' @param printQ       Print flag
#' @return The function will XX
#'
#' @export
approx.KL.divergence <- function(dat.list, bounds=NULL, num.points=1000, bw = "nrd0", log.base=exp(1), renormalizeQ=T, tol=9e-19, eps=.Machine$longdouble.eps, subdivisions=2000, plotQ=F, printQ=F) {

  if(is.null(bounds)) {
    bounds.loc <- range(unlist(dat.list)) # Use the overall sample range if no bounds are given
  } else {
    bounds.loc <- bounds
  }

  # Initial density fits
  den1  <- density(dat.list[[1]], from=bounds.loc[1], to=bounds.loc[2], n=num.points, bw=bw)
  den2  <- density(dat.list[[2]], from=bounds.loc[1], to=bounds.loc[2], n=num.points, bw=bw)
  den1y <- den1$y
  den2y <- den2$y

  # Reference x-axis for both distributions:
  if(sum(!(den1$x == den2$x)) != 0) {
    stop("x-axis between density1 and density2 are different!")
  } else {
    xax <- den1$x # x-axis for both densities
  }

  # Initial splined densities
  den1f <- splinefun(xax, den1y, method="monoH.FC")
  den2f <- splinefun(xax, den2y, method="monoH.FC")

  if(renormalizeQ == T) {

    # Re-normalize splined densities
    N1 <- 1/integrate(den1f, lower = min(xax), upper = max(xax))$value
    N2 <- 1/integrate(den2f, lower = min(xax), upper = max(xax))$value
    if(printQ==T){
      print("First round renormalization constants:")
      print(paste0("Density1: ", N1))
      print(paste0("Density2: ", N2))
      print("----------------------")
    }

    den1f <- splinefun(xax, N1*den1y, method="monoH.FC")
    den2f <- splinefun(xax, N2*den2y, method="monoH.FC")

    norm1 <- integrate(den1f, lower = min(xax), upper = max(xax))$value
    norm2 <- integrate(den2f, lower = min(xax), upper = max(xax))$value
    if(printQ==T){
      print("Norm densities after first round renormalization:")
      print(paste0("Integral(Density1): ", norm1))
      print(paste0("Integral(Density2): ", norm2))
      print("---------------------------")
    }

    # Eliminate 0 and exceedingly small density points.
    # This is done to prevent Inf values in the KL log ratio.
    den1y <- den1f(xax)
    den2y <- den2f(xax)
    den1y[which(den1y <=tol)] <- eps
    den2y[which(den2y <=tol)] <- eps

    # Spline densities again after 0 density values eliminated
    den1f <- splinefun(xax, den1y, method="monoH.FC")
    den2f <- splinefun(xax, den2y, method="monoH.FC")

    # Re-normalize densities again after 0 density values eliminated
    N1 <- 1/integrate(den1f, lower = min(xax), upper = max(xax))$value
    N2 <- 1/integrate(den2f, lower = min(xax), upper = max(xax))$value
    if(printQ==T){
      print("Second round renormalization constants:")
      print(paste0("Density1: ", N1))
      print(paste0("Density2: ", N2))
      print("----------------------")
    }

    den1f <- splinefun(xax, N1*den1y, method="monoH.FC")
    den2f <- splinefun(xax, N2*den2y, method="monoH.FC")

    norm1 <- integrate(den1f, lower = min(xax), upper = max(xax))$value
    norm2 <- integrate(den2f, lower = min(xax), upper = max(xax))$value
    if(printQ==T){
      print("Norm densities after second round renormalization:")
      print(paste0("Integral(Density1): ", norm1))
      print(paste0("Integral(Density2): ", norm2))
      print("---------------------------")
    }

    # Throw error if densities aren't normalized:
    if(all.equal(norm1, 1) == F) {
      stop("Density1 not normalized!")
    }

    if(all.equal(norm2, 1) == F) {
      stop("Density2 not normalized!")
    }

  }


  #plot(xax, den1y)
  #plot(xax, den2y)
  #cbind(xax, den1f(xax), den2f(xax), den1f(xax)*log(den1f(xax)/den2f(xax)))

  kl.kernf   <- splinefun(xax, den1f(xax)*log(den1f(xax)/den2f(xax), base = log.base) )
  kl.div.val <- integrate(kl.kernf, lower = min(xax), upper = max(xax), subdivisions=subdivisions)$value

  if(plotQ == T){
    print("**** Use Plot Window Arrows To Scroll Between All Four Plots ****")

    plot(xax, den1f(xax), typ="l", main="Density1")
    plot(xax, den2f(xax), typ="l", main="Density2")
    plot(xax, kl.kernf(xax), typ="l", main="Kullback-Leibler Kernel")

    plot(xax, kl.kernf(xax), typ="l", main="All", ylab="")
    lines(xax, den1f(xax), col="blue")
    lines(xax, den2f(xax), col="green")

  }

  kl.mat  <- cbind(xax, den1y, den2y, den1y * log(den1y/den2y) )
  colnames(kl.mat) <- c("xax", "den1y", "den2y", "kl.kern")

  kl.info <- list(kl.div.val, xax, den1f, den2f, kl.kernf, kl.mat)
  names(kl.info) <- c("kl.div", "xax", "den1f", "den2f", "kl.kernf", "kl.mat")

  return(kl.info)

}


#' Function to roughly estimate a kernel density estimate from a sample
#'
#' Function to roughly estimate a kernel density estimate from a sample. Useful with function in entropy package.
#'
#' @param dat.list     Samples from two distributions. Send in as a list in case samples are not the same length
#' @param bounds       Left and right bounds on distribution. If NULL, min/max of sample used
#' @param num.points   Length of support domain (x-axis) to be used for distribution
#' @param bw           Bandwidth to be used for density fits. Cf. density()
#' @param method       Fit method for density. Cf. density()
#' @param tol          Minimum fit density value. Below tol, density values will be replaced with eps. If NULL, zero density values are kept.
#' @param eps          Replacement density value for densities below tol
#' @param plotQ        Plot flag
#' @param bre          Parameter bre for hist(). Defaults to length(pretty(dsamp))
#' @param printQ       Print flag
#'
#' @return The function will XX
#' @export
approx.density.func <- function(dsamp, bounds=NULL, num.points=1000, bw = "nrd0", method="monoH.FC", elim.zero.dsQ=T, tol=1e-19, eps=.Machine$longdouble.eps, plotQ=F, bre=NULL, printQ=F) {

  if(is.null(bounds)) {
    bounds.loc <- range(dsamp) # Use the overall sample range if no bounds are given
  } else {
    bounds.loc <- bounds
  }

  # Initial density fit
  den   <- density(dsamp, from=bounds.loc[1], to=bounds.loc[2], n=num.points, bw=bw)
  den.y <- den$y

  # Reference x-axis for distribution:
  xax <- den$x

  # Initial splined density
  den.f <- splinefun(xax, den.y, method=method)

  # Re-normalize splined density
  N1 <- 1/integrate(den.f, lower = min(xax), upper = max(xax))$value
  if(printQ==T){
    print("First round renormalization constant:")
    print(paste0("N: ", N1))
    print("----------------------")
  }

  den.f <- splinefun(xax, N1*den.y, method=method)

  norm1 <- integrate(den.f, lower = min(xax), upper = max(xax))$value
  if(printQ==T){
    print("Norm density after first round renormalization:")
    print(paste0("Integral[p(x)]: ", norm1))
    print("---------------------------")
  }

  # If a tol is given, eliminate 0 and exceedingly small density points, replace with eps and re-normalize again.
  if(!is.null(tol)) {

    den.y <- den.f(xax)
    den.y[which(den.y <= tol)] <- eps

    # Spline density again after 0 density values eliminated
    den.f <- splinefun(xax, den.y, method=method)

    # Re-normalize densities again after 0 density values eliminated
    N1 <- 1/integrate(den.f, lower = min(xax), upper = max(xax))$value
    if(printQ==T){
      print("Second round renormalization constants:")
      print(paste0("N: ", N1))
      print("----------------------")
    }

    den.f <- splinefun(xax, N1*den.y, method=method)

    norm1 <- integrate(den.f, lower = min(xax), upper = max(xax))$value
    if(printQ==T){
      print("Norm density after second round renormalization:")
      print(paste0("Integral[p(x)]: ", norm1))
      print("---------------------------")
    }

  }

  # Throw error if density isn't normalized:
  if(all.equal(norm1, 1) == F) {
    stop("Density not normalized!")
  }

  if(plotQ == T){
    if(is.null(bre)){
      bre.loc <- length(pretty(dsamp))+1
    } else {
      bre.loc <- bre
    }
    hist(dsamp, probability=T, xlim=c(min(xax), max(xax)), ylim=c(0,max(N1*den.y)), bre=bre.loc, main="Fit Density")
    lines(xax, den.f(xax))
  }

  den.info <- list(xax, den.f)
  names(den.info) <- c("xax", "den.f")

  return(den.info)

}
