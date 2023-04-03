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
# Function aliases for get.mfp
#' @export
get_model_file_path <- get.mfp
#' @export
get.model.file.path <- get.mfp


#' Open specified JAGS or Stan model file contained in bayesutils
#'
#' Open the specified JAGS or Stan model file contained in bayesutils
#'
#' @param XX XX
#' @return The function will XX
#'
#'
#' @export
open_mf <- function(model.file.name) {

  file.edit(get.mfp(model.file.name))

}
# Function aliases for open_mf
#' @export
op.mf <- open_mf
#' @export
op.model.file <- open_mf
#' @export
open_model_file <- open_mf


#' Write a JAGS or Stan model to file to the tempdir
#'
#' Write a JAGS or Stan model to a temp file. Model should be formatted as a string
#' in an R script. This is really intended for use with JAGS since rstan can already
#' deal with model strings but JAGS needs a stand alone file.
#'
#' @param XX XX
#' @return The function will XX
#'
#'
#' @export
write.tmp.model.file <- function(model.string) {

  tmp.file.path <- tempfile()
  tmps          <- file(tmp.file.path,"w")
  cat(model.string,file=tmps) # Write model string to temp file
  close(tmps)

  return(tmp.file.path)

}
# Function aliases for write.tmp.model.file
#' @export
write.model.file      <- write.tmp.model.file
#' @export
write.mf              <- write.tmp.model.file
#' @export
write_mf              <- write.tmp.model.file
#' @export
write_model_file      <- write.tmp.model.file
#' @export
write_temp_model_file <- write.tmp.model.file



#' Read in specified JAGS or Stan model file contained in bayesutils or at the end of a specified path as a string
#'
#' Read in specified JAGS or Stan model file contained in bayesutils or at the end of a
#' specified path string. This is useful (and keeps code bloat down) when writing your
#' own JAGS and Stan files that you want to load in and use. If no model path is specified
#' the function looks for the model file in the bayesutils library.
#'
#' @param XX XX
#' @return The function will XX
#'
#'
#' @export
read.model.file <- function(model.file.name, model.path=NULL) {

  if(is.null(model.path)) {
    code.string <- paste(readLines(get.mfp(model.file.name)),collapse='\n')
  } else {
    code.string <- paste(readLines(paste0(model.path, model.file.name)),collapse='\n')
  }

  return(code.string)

}
# Function aliases for read.model.file
#' @export
read.mf         <- read.model.file
#' @export
read_mf         <- read.model.file
#' @export
read_model_file <- read.model.file


#' Download and load a script file
#'
#' Download and load a script file. Intended to get script files for the Notes
#'
#' @param XX XX
#' @return The function will XX
#'
#'
#' @export
get.script <- function(script.name, url_head=NULL, download_location=NULL) {

  if(is.null(url_head)) {
    url_head.loc <- "https://raw.githubusercontent.com/npetraco/MATFOS705/master/Notes_scripts_bank"
  } else {
    url_head.loc <- url_head
  }

  if(is.null(download_location)) {
    download_location.loc <- tempdir()
  } else {
    download_location.loc <- download_location
  }

  url_loc <- paste0(url_head.loc, "/", script.name)
  #print(url_loc)

  file_loc <- paste0(download_location.loc,"/",script.name)
  #print(file_loc)

  download.file(url_loc, file_loc)
  print("File downloaded to:")
  print(file_loc)
  file.edit(file_loc)

}


#' Get a model file or download and load a script file
#'
#' Get a model file or download and load a script file. Combines functionality of
#' get.script() and open_mf() into one function for easier use.
#'
#' @param XX XX
#' @return The function will XX
#'
#'
#' @export
get_file <- function(file.name, url_head=NULL, download_location=NULL){

  # First determine if file.name is a JAGS, Stan or R-script file:
  nme.vec <- strsplit(file.name, split = ".", fixed = T)[[1]]
  if(("bug" %in% nme.vec) | ("stan" %in% nme.vec)) { # Is it a model file?

    open_mf(file.name)

  } else { # Otherwise assume its a script file

    get.script(file.name, url_head, download_location)

  }

}
