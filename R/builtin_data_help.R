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


#' Gelman et al. Stop and frisk data with noise added to protect confidentiality
#'
#' Gelman et al. Stop and frisk data with noise added to protect confidentiality. Precincts are
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
