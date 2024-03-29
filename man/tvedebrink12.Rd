% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/builtin_data_help.R
\docType{data}
\name{tvedebrink12}
\alias{tvedebrink12}
\title{Logistic regression coefficients from Tvedebrink 2012}
\format{
An object of class \code{list} of length 3.
}
\usage{
data(tvedebrink12)
}
\description{
Logistic regression coefficients for dropout rate study by from Tvedebrink et al 2012. Log-odds
of dropout at each locus are computed as: (b0-locus + g0-#cyc) + (b1-locus + g1-#cyc)*logH. The
intercepts, b0-locus, differ for each locus however the slopes, b1-locus, are the same. These both
also corredpond to 28-PCR thermocycles. To obtain log-odds for 29 and 30-PCR thermocycles, add in
intercept (g0-#cyc) and slope (g1-#cyc) corrections to the 28-cycle coefficients. Log(H) is
related to log of the peak height(s) of the alleals at the locus (which in turn is related to the
amount of DNA in the sample). See paper for more detail.
}
\examples{
data(tvedebrink12)
}
\references{
T Tvedebrink, PS Eriksen, M Asplund, HS Mogensen, N Morling. Allelic drop-out
probabilities estimated by logistic regression—Further considerations and practical implementation.
Forensic Science International: Genetics 6 (2012) 263–267.
}
\keyword{datasets}
