#' XXXX
#'
#' XXXX
#'
#' @param XX XX
#' @return The function will XX
#'
#'
#' @export
autocorrelation.plots <- function(chains.array, pars = NULL) {

  param.names <- dimnames(chains.array)$parameters

  if(is.null(pars)) {
    param.names.loc <- param.names
  } else {
    param.names.loc <- pars
  }
  #print(param.names.loc)

  for(i in 1:length(param.names.loc)) {

    slice.idx  <- which(param.names.loc == param.names.loc[i])
    chains.mat <- chains.array[,,slice.idx]
    if(class(chains.mat)[1] == "numeric") {
      num.chains <- 1
    } else {
      num.chains <- ncol(chains.mat)
    }

    print(paste0(param.names.loc[i], " is array slice: ", slice.idx, " and has ", num.chains, " chains."))

    if((num.chains > 1) & (num.chains <= 4)) {

      if(!is.null(dev.list())) {
        dev.off()
      }

      par(mfrow=c(2,2))
      for(j in 1:num.chains) {
        acf(chains.mat[,j], main=paste0(param.names.loc[i], " chain: ", j) )
      }

    } else {
      print(paste0(param.names.loc[i], " has 1 chain or more than 4 chains. Plotting by chain instead."))
      for(j in 1:num.chains) {

        if(!is.null(dev.list())) {
          dev.off()
        }

        if(num.chains > 1) {
          acf(chains.mat[,j], main=paste0(param.names.loc[i], " chain: ", j) )
        } else {
          acf(chains.mat, main=paste0(param.names.loc[i], " chain: ", j) )
        }


        if(j < num.chains){
          invisible(readline(prompt="Press [enter] to continue"))
        }
      }

    }

    if(i < length(param.names.loc)) {
      invisible(readline(prompt="Press [enter] to continue"))
    }
  }

  # Reset plot window to one plot before exiting
  par(mfrow=c(1,1))

}
