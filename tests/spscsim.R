library(bayesutils)
library(sn)

# Simulate scores

sampu <- rsn(n=30, xi=1, omega=1.5, alpha=10)
hist(sampu)
min(sampu)

samps <- rsn(n=30, xi=6, omega=1.3, alpha=-10)
hist(samps)

hist(c(sampu,samps))

transactions <- data.frame(c(round(sampu,2),round(samps,2)), c(rep("not.fraud",30), rep("fraud",30)))
colnames(transactions) <- c("suspicion.score", "transaction.type")
transactions

save(transactions, file="data/transactions.RData")
