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
