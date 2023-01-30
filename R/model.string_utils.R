#' Write a JAGS or Stan model to file
#'
#' Write a JAGS or Stan model to a temp file. Model should be formatted as a string. Intended for
#' use with JAGS since rstan can already deal with model strings but JAGS needs a stand alone file.
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
