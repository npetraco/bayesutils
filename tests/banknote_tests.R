library(MixGHD)

data("banknote")

gidx <- which(banknote$Status == "genuine")
cidx <- which(banknote$Status == "counterfeit")

hist(banknote$Length)
hist(banknote$Length[gidx])
hist(banknote$Length[cidx])

