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


indkm.counts <- read.csv("data/indkm.counts.csv", header=F)
indkm.counts <- as.matrix(indkm.counts)
save(indkm.counts, file="data/indkm.counts.RData")

