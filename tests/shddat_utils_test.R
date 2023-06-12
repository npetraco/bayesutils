library(bayesutils)
#library(tidyr)

head(shedder)

# shd  <- shedder
# shd2 <- shd %>% filter(location=="LU")
# shd3 <- shd2[,-2]
# shd3 <- shd2 %>% gather(reps, dna.amt, DNA.amt1:DNA.amt3)
# shd3[,3] <- as.numeric(sapply(1:nrow(shd3), function(xx){strsplit(shd3[xx,3], split = "t")[[1]][2]}))
# shd3 <- shd3 %>% arrange(subjectID)

shd4 <- shedder.extract.data(
  shedder.data       = shedder,
  location.variable  = "LU",
  response.variable  = "log.amount.DNA",
  response.statistic = max,
  orderQ             = T)

shd5 <- shedder.summary.extract.data(
  shedder.extracted.data = shd4,
  response.variable      = "log.amount.DNA",
  order.statistic        = mean,
  orderQ                 = T)

shedder.donor.boxplot(
  shedder.data       = shedder,
  location.variable  = "N",
  response.variable  = "log.amount.DNA",
  response.statistic = sd,
  orderQ             = T)
