#**************************************************************************
# Title: Howell_height.R
# Author: William Murrah
# Description:
# Created: Sunday, 22 September 2019
# R version: R version 3.6.1 (2019-07-05)
# Directory: /home/wmmurrah/Projects/Learning/CognitiveModeling
#**************************************************************************
# packages used -----------------------------------------------------------

library(rethinking)  

data("Howell1")

df <- Howell1[Howell1$age >= 18, ]
str(df)
precis(df)
curve(dnorm(x, 178, 20), from = 100, to = 250)

# Prior predictive simulation.

sample_mu <- rnorm(1e4, 178, 100)
sample_sigma <- runif(1e4, 0, 50)
prior_h <- rnorm(1e4, sample_mu, sample_sigma)
dens(prior_h)
abline(v = mean(prior_h))
abline(v = 0)
abline(v = 272)


# Grid approximation.
mu.list <- seq(140, 160, length.out = 200)
sigma.list <- seq(4, 9, length.out = 200)
post <- expand.grid(mu = mu.list, sigma = sigma.list)
post$LL <- sapply(1:nrow(post), function(i) sum(dnorm(
  df$height,
  mean = post$mu[i],
  sd = post$sigma[i],
  log = TRUE
)))
post$prod <- post$LL + dnorm(post$mu, 178, 20, TRUE) + 
  dunif(post$sigma, 0, 50, TRUE)
post$prob <- exp(post$prod - max(post$prod))


contour_xyz(post$mu, post$sigma, post$prob)
with(post, image_xyz(mu, sigma, prob))
with(post, scatter3d(x = mu, z = sigma, y = prob))
dens(sample_mu)
dens(sample_sigma)
HPDI(sample_mu)


# with quap.
flist <- alist(
  height ~ dnorm(mu, sigma),
  mu <- dnorm(178, 20),
  sigma <- dunif(0, 50)
)

m4.1 <- quap(flist, data = df)
precis(m4.1)

# with stan
library(rstan)

standat <- list(
  height = df$height,
  N = length(df$height)
)

m4.1stan <- stan(file = "stan/Howell_height.stan", 
                 data = standat,
                 pars = c("mu", "sigma"),
                 iter = 200000,
                 chains = 2,
                 thin = 1)
precis(m4.1)
precis(m4.1stan)

