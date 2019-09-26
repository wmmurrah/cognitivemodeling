#**************************************************************************
# Title: Rate_1_jags.R
# Author: William Murrah
# Description:
# Created: Thursday, 26 September 2019
# R version: R version 3.6.1 (2019-07-05)
# Directory: /home/wmmurrah/Projects/Learning/CognitiveModeling
#**************************************************************************
# packages used -----------------------------------------------------------
  
library(rjags)

dat <- list(k = 5, n = 10)

rate1mod <- jags.model(file = "jags/Rate_1.jags", data = dat, 
                       n.chains = 2)

rate1fit <- jags.samples(rate1mod, variable.names = c("theta"),
                         n.iter = 1e4)

with(rate1fit, {
  hist(theta, breaks = "fd", col = "orange", prob = TRUE,
       ylim = c(0, 3))
  curve(dnorm(x, mean(theta), sd(theta)), add = TRUE)
})
