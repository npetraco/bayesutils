#' Get path to the specified JAGS or Stan model file contained in bayesutils
#'
#' Get path to the specified JAGS or Stan model file contained in bayesutils
#'
#' @param XX XX
#' @return The function will XX
#'
#'
#' @export
get.mfp <- function(model.file.name) {

  nme.vec <- strsplit(model.file.name, split = ".", fixed = T)[[1]]
  fext.u  <- nme.vec[length(nme.vec)]
  fext.pu <- nme.vec[length(nme.vec) - 1]

  # Check file extension first
  if( !( (fext.u == "bug") | (fext.u == "stan") | (paste0(fext.pu,".",fext.u) == "bug.R") ) ) {
    stop("model.file.name must end in .bug, .bug.R or .stan")
  }


  # Now see what kind of model is requested:
  if("bug" %in% nme.vec) { # Is it a bug file?

    if("R" == nme.vec[length(nme.vec)]) { # Check if user put on the .R extension at the end

      mf.path <- system.file(paste0("jags/",model.file.name), package = "bayesutils")

    } else {

      mf.path <- system.file(paste0("jags/",model.file.name,".R"), package = "bayesutils")

    }

  } else if("stan" %in% nme.vec) { # Is it a stan file?

    mf.path <- system.file(paste0("stan/",model.file.name), package = "bayesutils")

  } else {

    stop("model.file.name must be a .bug, .bug.R or .stan")

  }

  if(mf.path == "") { # Last check:
    stop("model.file.name must end in .bug, .bug.R or .stan")
  }

  return(mf.path)

}


#' Open specified JAGS or Stan model file contained in bayesutils
#'
#' Open the specified JAGS or Stan model file contained in bayesutils
#'
#' @param XX XX
#' @return The function will XX
#'
#'
#' @export
op.mf <- function(model.file.name) {

  file.edit(get.mfp(model.file.name))

}
