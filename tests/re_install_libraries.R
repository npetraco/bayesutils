# If R is updated, re-install libraries

#library(installr)
#copy.packages.between.libraries(ask = T)
#.libPaths()
install.packages("roxygen2")
install.packages("R2jags")
install.packages("coda")
install.packages("rstan")
install.packages("bayesplot")
install.packages("bridgesampling")
install.packages("extraDistr")
install.packages("BiocManager")

BiocManager::install("Rgraphviz")
BiocManager::install("RBGL")

install.packages("gRbase")
install.packages("gRain")
