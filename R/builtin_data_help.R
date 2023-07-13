#' Neel and Wells KM CMS data combined with Petraco group automatically extracted KM CMS data
#'
#' Neel and Wells known match (KM) consecutive matching striae (CMS) data combined with Petraco group automatically extracted CMS data
#'
#' @docType data
#'
#' @usage data(cms.km)
#'
#' @keywords datasets
#'
#' @references Neel, M and Wells M. “A Comprehensive Analysis of Striated Toolmark Examinations. Part 1: Comparing Known Matches to Known Non-Matches”, AFTE J 39(3):176-198 2007.
#'
#' N. D. K. Petraco, L. Kuo, H. Chan, E. Phelps, C. Gambino, P. McLaughlin, Frani Kammerman, P. Diaczuk, P. Shenkin, N. Petraco and J. Hamby, "Estimates of Striation Pattern Identi cation Error Rates by Algorithmic Methods," AFTE J. 45(3), 235 (2013)
#'
#' @examples
#' data(cms.km)
"cms.km"


#' Neel and Wells KNM CMS data combined with Petraco group automatically extracted KNM CMS data
#'
#' Neel and Wells known non match (KNM) consecutive matching striae (CMS) data combined with Petraco group automatically extracted KNM CMS data
#'
#' @docType data
#'
#' @usage data(cms.knm)
#'
#' @keywords datasets
#'
#' @references Neel, M and Wells M. “A Comprehensive Analysis of Striated Toolmark Examinations. Part 1: Comparing Known Matches to Known Non-Matches”, AFTE J 39(3):176-198 2007.
#'
#' N. D. K. Petraco, L. Kuo, H. Chan, E. Phelps, C. Gambino, P. McLaughlin, Frani Kammerman, P. Diaczuk, P. Shenkin, N. Petraco and J. Hamby, "Estimates of Striation Pattern Identi cation Error Rates by Algorithmic Methods," AFTE J. 45(3), 235 (2013)
#'
#' @examples
#' data(cms.knm)
"cms.knm"


#' Simulated counts of corresponding minutae for mated pairs (KM) of latent fingerprints
#'
#' Simulated examiner designated counts of corresponding minutae for mated pairs (KM) of
#' latent fingerprints. Simulations based on Ulrey 2014 with 165 examiners judging 231
#' mated pairs. There are 1801 examinations of mated pairs among these simulated
#' examiners. Each entry represents how many corresponding minutae were designated
#' leading the examiner to judge the pair a match. Summary statistics of this dataset
#' are consistent with the Ulrey 2014 paper.
#'
#' @docType data
#'
#' @usage data(indkm.counts)
#'
#' @keywords datasets
#'
#' @references BT Ulery, RA Hicklin, MA Roberts, J Buscaglia. Measuring What Latent
#' Fingerprint Examiners Consider Sufficient Information for Individualization
#' Determinations; PLoS ONE 2014; 9(11): e110179. https://doi.org/10.1371/journal.pone.0110179
#'
#'
#' @examples
#' data(indkm.counts)
"indkm.counts"


#' Fake data for a black box firearms examiner error rate study
#'
#' Fake data for a black box firearms examiner error rate study. Data based on Baldwin 2014 study.
#' There were 218 examiners in the study, each of whom examined 9 or 10 sets of non match (NM)
#' cartridge cases and 5 sets of matching (M) cartridge cases. Baldwin does not break down the data
#' examiner by examiner however, so we base this fake data on several assumptions. First, Baldwin
#' does not say which examiners made how many errors, so we guess. Second, Baldwin does not say
#' which examines called how many inconclusives, so we guess those too. We use clues in his text
#' to guess as best we can. The summary statistics, error rates and interval estimates of this
#' fake data are consistent with the results of Baldwin.
#'
#' @docType data
#'
#' @usage data(fbbf)
#'
#' @keywords datasets
#'
#' @references DP Baldwin, SJ Bajic, M Morris, D Zamzow. A Study of False-Positive and
#' False-Negative Error Rates in Cartridge Case Comparisons. Ames Laboratory, USDOE,
#' Technical Report # IS-5207; https://www.ojp.gov/pdffiles1/nij/249874.pdf
#'
#' @examples
#' data(fbbf)
"fbbf"


#' Logistic regression coefficients from Tvedebrink 2012
#'
#' Logistic regression coefficients for dropout rate study by from Tvedebrink et al 2012. Log-odds
#' of dropout at each locus are computed as: (b0-locus + g0-#cyc) + (b1-locus + g1-#cyc)*logH. The
#' intercepts, b0-locus, differ for each locus however the slopes, b1-locus, are the same. These both
#' also corredpond to 28-PCR thermocycles. To obtain log-odds for 29 and 30-PCR thermocycles, add in
#' intercept (g0-#cyc) and slope (g1-#cyc) corrections to the 28-cycle coefficients. Log(H) is
#' related to log of the peak height(s) of the alleals at the locus (which in turn is related to the
#' amount of DNA in the sample). See paper for more detail.
#'
#' @docType data
#'
#' @usage data(tvedebrink12)
#'
#' @keywords datasets
#'
#' @references T Tvedebrink, PS Eriksen, M Asplund, HS Mogensen, N Morling. Allelic drop-out
#' probabilities estimated by logistic regression—Further considerations and practical implementation.
#' Forensic Science International: Genetics 6 (2012) 263–267.
#'
#' @examples
#' data(tvedebrink12)
"tvedebrink12"


#' Fake allelic dropout data generated from Tvedebrink 2012, 28-cycle logistic regression coefficients.
#'
#' Fake allelic dropout data generated from Tvedebrink 2012, 28-cycle logistic regression coefficients.
#' Data is a list of matrices for loci: "D3", "vWA", "D16", "D2", "D8", "SE33", "D19", "TH0", "FGA",
#' "D21" and "D18". Columns of the matrices are H (related to alleal peak height(s) at each locus),
#' log(H) and a dropout indicator (D.vec). In the D.vec column, 1 = peak dropped out, 0 = peak present.
#' D.vec data is fake and simulated using Tvedebrink 2012 b0 and b1 coefficients. Simulation model:
#' b0 ~ normal(b0-2012, b0se-2012), b1 ~ normal(b1-2012, b1se-2012), log-Odds = b0 + b1*logH,
#' pD = p(dropout) = inv-logit(pD) and D.vec[i] = D.vec(H) ~ bernoulli(pD(H)). Logistic regression
#' coefficients used in the model are contained in tvedebrink12.
#'
#' @docType data
#'
#' @usage data(dropout.info)
#'
#' @keywords datasets
#'
#' @references T Tvedebrink, PS Eriksen, M Asplund, HS Mogensen, N Morling. Allelic drop-out
#' probabilities estimated by logistic regression—Further considerations and practical implementation.
#' Forensic Science International: Genetics 6 (2012) 263–267.
#'
#' @examples
#' data(dropout.info)
"dropout.info"


#' Gelman et al. stop and frisk data with noise added to protect confidentiality
#'
#' Gelman et al. stop and frisk data with noise added to protect confidentiality. Precincts are
#' numbered 1-75, ethnicity 1=black, 2=hispanic, 3=white, crime type 1=violent, 2=weapons, 3=property,
#' 4=drug.
#'
#' @docType data
#'
#' @usage data(frisk)
#'
#' @keywords datasets
#'
#' @references A Gelman, J Fagan, A Kiss. An Analysis of the New York City Police Department’s
#' "Stop-and-Frisk" Policy in the Context of Claims of Racial Bias. Journal of the American Statistical
#'  Association, Vol. 102, No. 479, Pp. 813-823, 2007.
#'
#' http://www.stat.columbia.edu/~gelman/arm/examples/police/frisk_with_noise.dat
#'
#' @examples
#' data(frisk)
"frisk"


#' Fake average daily active users per week over the course of a year
#'
#' Fake (simulated) average daily active users per week over the course of a year on a fake
#' social media site. Each row of the data is a month. Each column represents one of the four
#' weeks in a month. Simulation based on insights found here: https://financesonline.com/number-of-twitter-users/
#'
#' @docType data
#'
#' @usage data(aduf)
#'
#' @keywords datasets
#'
#' @references https://financesonline.com/number-of-twitter-users/
#'
#'
#' @examples
#' data(aduf)
"aduf"


#' Fake DNA shedder data
#'
#' Fake (simulated) shed amounts of touch DNA. Simulation based on MS thesis work of Xiao Chen.
#' (Fake) Shed amounts of touch DNA are for 50 (fake) participants with three replicate assays each
#' from seven locations on the body. A "W" suffix indicates washed, a "U" suffix indicates unwashed.
#'
#' @docType data
#'
#' @usage data(shedder)
#'
#' @keywords datasets
#'
#' @references X. Chen "Evaluating a Test for Shedding Propensity Using Tape Lifts from Different Skin Locations", Dec-27-2021.
#'
#' https://academicworks.cuny.edu/jj_etds/199/
#'
#'
#' @examples
#' data(shedder)
"shedder"

#' Utility to help simplify (fake) shedder data
#'
#' Utility to help simplify (fake) shedder data
#'
#' The complete "shedder" data is complicated. Analyzing it all at once is not easy. The function is
#' to help slice out relevant parts of the  "shedder" data for visualization and analysis purposes.
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @export
shedder.extract.data <- function(shedder.data, location.variable, response.variable="amount.DNA", response.statistic, orderQ=F) {

  # Slice out location data
  ddat <- shedder.data %>% filter(location==location.variable)
  ddat <- ddat %>% tidyr::gather(rep.num, !!sym(response.variable), DNA.amt1:DNA.amt3)

  # Responses stored as just DNA amounts. Transform response here if requested
  if(response.variable == "amount.DNA.cen"){
    ddat[,4] <- ddat[,4] - mean(ddat[,4])
  } else if(response.variable == "amount.DNA.std"){
    ddat[,4] <- (ddat[,4] - mean(ddat[,4]))/sd(ddat[,4])
  } else if(response.variable == "log.amount.DNA") {
    ddat[,4] <- log(ddat[,4])
  } else if(response.variable == "log.amount.DNA.cen"){
    ddat[,4] <- log(ddat[,4]) - mean(log(ddat[,4]))
  } else if(response.variable == "log.amount.DNA.std"){
    ddat[,4] <- (log(ddat[,4]) - mean(log(ddat[,4])))/sd(log(ddat[,4]))
  }

  # Put on replicate numbers:
  ddat[,3] <- as.numeric(sapply(1:nrow(ddat), function(xx){strsplit(ddat[xx,3], split = "t")[[1]][2]}))
  ddat <- ddat %>% arrange(subjectID)

  # Tack on column of response statistics as a function of subjectID:
  ddat <- ddat %>% group_by(subjectID) %>% mutate(ordering_statistic=response.statistic(!!sym(response.variable)))

  # Order by subjectID response statistics values if requested:
  if(orderQ==T) {
    ddat <- arrange(ddat, ordering_statistic)
  }

  ddat <- ddat %>% ungroup() %>% mutate(ord_num = dense_rank(ddat$ordering_statistic) )

  return(ddat)
}

#' Utility to help summarize simplified (fake) shedder data
#'
#' Utility to help summarize simplified (fake) shedder data
#'
#' The complete "shedder" data is complicated. Analyzing it all at once is not easy. The function is
#' to help slice out relevant parts of the "shedder" data and summarize it for visualization and analysis purposes.
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @export
shedder.summary.extract.data <- function(shedder.extracted.data, response.variable, order.statistic=mean, orderQ=T) {

  dat.sumry <- shedder.extracted.data %>% group_by(subjectID) %>%
    summarise(
      location           = unique(location),
      samp.size          = length(subjectID),
      ordering_statistic = order.statistic(!!sym(response.variable)),
      means              = mean(!!sym(response.variable)),
      ses                = mean(!!sym(response.variable))/sqrt(length(subjectID)) )

  if(orderQ==T) {
    dat.sumry <- arrange( dat.sumry, ordering_statistic)
  }
  dat.sumry <- dat.sumry %>% ungroup() %>% mutate(ord_num = dense_rank(dat.sumry$ordering_statistic))

  return(dat.sumry)

}

#' Utility to help plot simplified (fake) shedder donor data
#'
#' Utility to help plot simplified (fake) shedder donor data
#'
#' The complete "shedder" data is complicated. Analyzing it all at once is not easy. The function is
#' to plot the "shedder" data as a function of the donors for visualization purposes.
#'
#' @param XX The XX
#' @return The function will XX
#'
#'
#' @examples
#' AN EXAMPLE HERE
#'
#' @export
shedder.donor.boxplot <- function(shedder.data, location.variable, response.variable, response.statistic, orderQ=T) {

  dat.plot <- shedder.extract.data(
    shedder.data       = shedder.data,
    location.variable  = location.variable,
    response.variable  = response.variable,
    response.statistic = response.statistic,
    orderQ             = orderQ)

  if(orderQ==T) {
    dat.s.plot <- shedder.summary.extract.data(
      shedder.extracted.data = dat.plot,
      response.variable      = response.variable,
      orderQ                 = T,
      order.statistic        = response.statistic)

    boxplot(dat.plot$log.amount.DNA ~ factor(dat.plot$ord_num), xaxt="n", main=paste0(response.variable, " Loc: ", location.variable), ylab=response.variable, xlab="subject ID")
    points(dat.s.plot$ord_num, dat.s.plot$means, col="red", pch=16)

  } else {
    dat.s.plot <- shedder.summary.extract.data(
      shedder.extracted.data = dat.plot,
      response.variable      = response.variable,
      orderQ                 = F)

    boxplot(dat.plot$log.amount.DNA ~ dat.plot$subjectID, xaxt="n", main=paste0(response.variable, " Loc: ", location.variable), ylab=response.variable, xlab="subject ID")
    points(1:nrow(dat.s.plot), dat.s.plot$means, col="red", pch=16)
  }

  axis(1, at = 1:length(dat.s.plot$subjectID),  labels = dat.s.plot$subjectID,  las=2)

}


#' Fake financial fraud transaction data
#'
#' A simple faked financial transaction data set consisting of simulated suspicion scores for a group
#' of 60 transactions. 30 transactions were "ruled" not to be involved in fraud and 30 transactions
#' were "ruled" to be involved in fraud.
#'
#' @docType data
#'
#' @usage data(transactions)
#'
#' @keywords datasets
#'
#' @references  RJ Bolton, DJ Hand. "Statistical Fraud Detection: A review", Statist. Sci. 17(3): 235-255 (2002)
#'
#' https://projecteuclid.org/journalArticle/Download?urlId=10.1214%2Fss%2F1042727940
#'
#'
#' @examples
#' data(transactions)
"transactions"


#' Unclean MCMC chain
#'
#' An uncleaned up MCMC chain. Useful for exploring computation of convergence diagnostics and cleanup
#' methodologies.
#'
#' @docType data
#'
#' @usage data(clean.me.up.chain)
#'
#' @keywords datasets
#'
#'
#'
#' @examples
#' data(clean.me.up.chain)
"clean.me.up.chain"


#' Wine quality/chemical data
#'
#' Data for red and white variants of the Portuguese "Vinho Verde" wine and associated quality judgement scores.
#'
#' @docType data
#'
#' @usage data(wine)
#'
#' @keywords datasets
#'
#' @references P. Cortez, A. Cerdeira, F. Almeida, T. Matos and J. Reis. Modeling wine preferences by data mining from physicochemical properties. In Decision Support Systems, Elsevier, 47(4):547-553, 2009.
#'
#' @examples
#' data(wine)
"wine"


#' Wine cultivar data
#'
#' These data are the results of a chemical analysis of wines grown in the same region in Italy but derived from three different cultivars. The analysis determined the quantities of 13 constituents found in each of the three types of wines.
#' This is an old dataset and not sure of the original reference. See the link to the UCI database below.
#'
#' @docType data
#'
#' @usage data(wine2)
#'
#' @keywords datasets
#'
#' @references 1. cf. https://archive.ics.uci.edu/ml/datasets/Wine
#' @references 2. Forina, M. et al, PARVUS -An Extendible Package for Data Exploration, Classification and Correlation. Institute of Pharmaceutical and Food Analysis and Technologies, Via Brigata Salerno, 16147 Genoa, Italy.
#' @references 3. UCI Donor: Stefan Aeberhard, email: stefan-at-coral.cs.jcu.edu.au
#'
#' @examples
#' data(wine2)
"wine2"


#' NBA player data
#'
#' Data for some anonymous NBA players.
#' ht = height,
#' wt = weight,
#' fg.perc = field goal percentage,
#' ft.perc = free throw percentage,
#' avg.ppg = average points per game
#'
#' @docType data
#'
#' @usage data(nba)
#'
#' @keywords datasets
#'
#' @references The official NBA basketball Encyclopedia, Villard Books, 1989.
#'
#' @examples
#' data(nba)
"nba"


#' Gelman and Hill data on radon levels in houses in the state of Minnesota.
#'
#' Data taken directly from rstanarm
#' 919 obs. of 4 variables
#' log_radon Radon measurement from the house (log scale)
#' log_uranium Uranium level in the county (log scale)
#' floor Indicator for radon measurement made on the first floor of the house (0 = basement, 1 = first floor)
#' county County name (factor)
#'
#' @docType data
#'
#' @usage data(radon)
#'
#' @keywords datasets
#'
#' @references Gelman and Hill, Cambridge University Press, 2006.
#'
#' @examples
#' data(nba)
"radon"
