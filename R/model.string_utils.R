#' XXXX
#'
#' XXX
#' The function is XXXXXXX
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
