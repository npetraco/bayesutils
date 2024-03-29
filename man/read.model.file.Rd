% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/file_utils.R
\name{read.model.file}
\alias{read.model.file}
\title{Read in specified JAGS or Stan model file contained in bayesutils or at the end of a specified path as a string}
\usage{
read.model.file(model.file.name, model.path = NULL)
}
\arguments{
\item{XX}{XX}
}
\value{
The function will XX
}
\description{
Read in specified JAGS or Stan model file contained in bayesutils or at the end of a
specified path string. This is useful (and keeps code bloat down) when writing your
own JAGS and Stan files that you want to load in and use. If no model path is specified
the function looks for the model file in the bayesutils library.
}
