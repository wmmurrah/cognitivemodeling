
library(rstan)

dat <- list(
  n1 = 10,
  n2 = 10,
  k1 = 5,
  k2 = 7
)

rate2fit <- stan("stan/Rate_3.stan", "rate3", 
                 data = dat,
                 pars = c("theta"),
                 iter = 2000,
                 chains = 2,
                 thin = 1)

rate2fit
