#' HPDI and PI interval estimates from a parameter sample
#'
#' HPDI and PI interval estimates from a parameter sample
#'
#' The function is a wrapper for coda and R interval functionality
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @export
parameter.intervals <- function(param.sample, prob=0.95, plotQ=F, xlim=NULL, ylim=NULL) {

  # HPDIs:
  if(class(param.sample) == "numeric"){      # JAGS format
    hpd.int <- HPDinterval(as.mcmc(param.sample), c(prob))
    hpd.int <- c(hpd.int[1], hpd.int[2])
  } else if(class(param.sample) == "array"){ # Stan format
    hpd.int <- HPDinterval(as.mcmc(as.vector(param.sample)), c(prob))
    hpd.int <- c(hpd.int[1], hpd.int[2])
  } else {
    stop("param.sample must be a numeric vector (JAGS) or an array (Stan)")
  }


  # PIs:
  alp    <- 1 - prob
  p.int  <- quantile(param.sample, c(alp/2, 1-alp/2))

  interval.mat <- rbind(
    hpd.int,
    p.int
  )
  colnames(interval.mat) <- c("lo", "hi")
  rownames(interval.mat) <- c(paste0("HPDI.",as.character(100*prob), "%"), paste0("PI.",as.character(100*prob), "%"))

  if(plotQ==T){
    hist(param.sample, bre=80, probability = T)
    points(hpd.int, c(0,0), col="blue", pch=16)
    points(p.int, c(0,0), col="red", pch=17)
    print(paste0(as.character(100*prob), "%"," HDPI = blue points"))
    print(paste0(as.character(100*prob), "%"," PI   = red points"))
  }

  return(interval.mat)

}


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
