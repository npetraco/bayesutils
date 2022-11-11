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
  if(class(param.sample) == "numeric"){
    hpd.int <- HPDinterval(as.mcmc(param.sample), c(prob))
    hpd.int <- c(hpd.int[1], hpd.int[2])
  } else if(class(param.sample) == "array"){
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
