#--------------------------------------------
#' @title HPDI
#' @description Highest posterior density interval
#'
#' @details Wrapper for coda's HPDinterval function, so usuers don't have to convert sampling output
#' to coda mcmc format.
#'
#' @param pot.table A potential (or node probability) table. Should be of class parray or array.
#'
#' @return The domain of random variates over which the bale is constructed.
#'
#' @examples
#' XXXX
#--------------------------------------------
HPDI <- function(param.samp, credibility) {

  raw.coda <- HPDinterval(mcmc(as.numeric(param.samp)), prob = credibility)

  post.param.lo <- raw.coda[1]
  post.param.hi <- raw.coda[2]

  Fx.post  <- ecdf(param.samp)
  plo <- Fx.post(post.param.lo)
  phi <- Fx.post(post.param.hi)
  cred.interval <- c(post.param.lo,post.param.hi)

  names(cred.interval) <- c(paste0(plo*100,"%"),paste0(phi*100,"%"))

  return(cred.interval)
}
