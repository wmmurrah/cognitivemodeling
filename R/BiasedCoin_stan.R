#**************************************************************************
# Title: BiasedCoin_stan.R
# Author: William Murrah
# Description:
# Created: Sunday, 06 October 2019
# R version: R version 3.6.1 (2019-07-05)
# Directory: /home/wmmurrah/Projects/Learning/CognitiveModeling
#**************************************************************************
# packages used -----------------------------------------------------------
library(rstan)

rm(list = ls())  

data1 <- list(
  h = 14,
  n = 26
)

data2 <- list(
  h = 113,
  n = 213
)

data3 <- list(
  h = 1130,
  n = 2130
)
samples1 <- stan("Models/ComputationalModelingCognitionBehavior/BiasedCoin/BiasedCoin.stan",
                data = data1, 
                chains = 2, 
                iter = 200000, 
                thin = 1)
samples2 <- stan(fit = samples1, data = data2)
samples3 <- stan(fit = samples1, data = data3)

print(samples1, digits = 3)
print(samples2, digits = 3)
print(samples3, digits = 3)

theta1 <- extract(samples1)$theta
theta2 <- extract(samples2)$theta
theta3 <- extract(samples3)$theta


plot(density(theta1), ylim = c(0, 40), xlim = c(0, 1), main = "",
     ylab = "Probability Density", xlab = "x", lty = "dashed")
lines(density(theta2), lty = "dotted")
lines(density(theta3), lty = "dotdash")
abline(v = .5)
curve(dbeta(x, 12, 12), add = TRUE, lwd = 2)
legend(.68, 38, c("{14, 26}", "{113, 213}","{1130, 2130}"),
       lty = c("dashed", "dotted", "dotdash"))
