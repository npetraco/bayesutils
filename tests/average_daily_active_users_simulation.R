# https://financesonline.com/number-of-twitter-users/
35-29.5 # Between 2019 and 2020 the number of daily active twitter users grew by this much in US (in millions of users)

5.5/12 # Average DAU per month ~ 450,000

adau <- 450  # Average daily active users
fluc <- 150  # Fluctuation
lowf <- function(){round(runif(4, adau-fluc, adau+fluc)) }         # Low Average daily active users/week
medf <- function(){round(runif(4, adau, adau+3*fluc)) }            # Med
hif  <- function(){round(runif(4, adau+3.5*fluc, adau+4.5*fluc)) } # High

# Simulate a year with a presidential election
aduf <- rbind(
  lowf(), # Dec low
  medf(), # Jan med
  medf(), # Feb med  # First primaries kickoffs
  hif(),  # Mar high # Month with a super Tuesday
  lowf(), # Apr low
  lowf(), # May low
  lowf(), # Jun low
  lowf(), # Jul low
  medf(), # Aug med
  medf(), # Sep med
  hif(),  # Oct high
  medf(), # Nov med # Election
  lowf() # Dec low
)

# The data set is meant to simulate what may be seen during a polarized election year where
# outside group(s) employ a strategy to use automated tools to infulence the election through
# social media.

colnames(aduf) <- c("wk1", "wk2", "wk3", "wk4")
rownames(aduf) <- c("Dec0", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
aduf

#       wk1  wk2  wk3  wk4
# Dec0  343  336  549  375
# Jan   648  845  775  459
# Feb   577  497  502  692
# Mar   975 1054 1048  983
# Apr   590  573  493  431
# May   346  315  380  528
# Jun   458  565  455  505
# Jul   545  419  439  373
# Aug   869  464  736  639
# Sep   825  715  563  611
# Oct  1013  987 1104 1069
# Nov   704  602  667  719
# Dec   455  589  377  471

save(aduf, file="data/aduf.RData")
