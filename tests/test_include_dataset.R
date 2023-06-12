library(bayesutils)

raw <- read.csv("/Users/karen2/latex/class/fos705/Applied_Bayes/Prototype_course/Notes_prototype_course/16_multi-parametric_models/scripts/KM_CMS.csv")
raw

cms.km <- as.matrix(raw[,2:11])
colnames(cms.km) <- c(paste0(2:10,"X"), "<10X")
rownames(cms.km) <- raw[,1]
names(attributes(cms.km)$dimnames) <- c("counts","run.lengths")
cms.km

save(cms.km, file="data/cms.km.RData")




raw2 <- read.csv("/Users/karen2/latex/class/fos705/Applied_Bayes/Prototype_course/Notes_prototype_course/16_multi-parametric_models/scripts/KNM_CMS.csv")
raw2

cms.knm <- as.matrix(raw2[,2:11])
colnames(cms.knm) <- c(paste0(2:10,"X"), "<10X")
rownames(cms.knm) <- raw2[,1]
names(attributes(cms.knm)$dimnames) <- c("counts","run.lengths")
cms.knm
raw2

save(cms.knm, file="data/cms.knm.RData")


cms.km
data("cms.km")

# Some fake fingerprints minutia counts used to call a match
indkm.counts <- read.csv("data/indkm.counts.csv", header=F)
indkm.counts <- as.matrix(indkm.counts)
save(indkm.counts, file="data/indkm.counts.RData")



# Fake Baldwin data
"total.poss.fp" # Total number of KNM comparisons for examiner i = total number of possible false positives
"num.incl.ds"   # For KNM comparisons -> number called inconclusive by examiner i
"num.fp"        # For KNM comparisons -> number of false positive identifications
"total.poss.fn" # Total number of KM comparisons for examiner i = total number of possible false negatives
"num.incl.ss"   # For KM comparisons -> number called inconclusive by examiner i
"num.fn"        # For KM comparisons -> number of false negative identifications

fbbfs <- read.csv("data/fake.blackbox.firearms.study.csv")

# Mix up rows to make look a little more realistic
ridxs  <- sample(1:nrow(fbbfs), size = nrow(fbbfs), replace = F)
fbbfs2 <- as.matrix(fbbfs[ridxs,])
rownames(fbbfs2) <- NULL
fbbfs2
examiner.ID <- 1:nrow(fbbfs2)
fbbf <- cbind(examiner.ID, fbbfs2)
colnames(fbbf) <- c("examiner.ID", "num.NM.comparisons", "num.NM.inconclusive", "num.false.positive", "num.M.comparisons", "num.M.inconclusive", "num.false.negative")

save(fbbf, file="data/fbbf.RData")



# a little bit of NBA player data:
nba <- read.csv("data/nba.csv", header = T)

save(nba, file="data/nba.RData")

library(bayesutils)
data("nba")


# Radon data from Gelman and Hill, taken directly from rstanarm
library(rstanarm)
radon
?radon
#write.csv(radon, file = "data/radon.csv", row.names = F)

save(radon, file="data/radon.RData")


