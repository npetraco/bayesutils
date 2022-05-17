#--------------------------------------------
#' @title dom
#' @description Spit out domain of a CPT or POT.
#'
#' @details Spit out domain of a CPT or POT. Useful with gRain.
#'
#' @param pot.table A potential (or node probability) table. Should be of class parray or array.
#'
#' @return The domain of random variates over which the bale is constructed.
#'
#' @examples
#' XXXX
#--------------------------------------------
dom <- function(pot.table) {
  return(names(attributes(pot.table)$dim))
}
