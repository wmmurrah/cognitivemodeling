
library(R2jags)


dat <- list(n1 = 10, n2 = 10, 
            k1 = 5, k2 = 7)

r3jagsfit <- jags(data = dat, parameters = "theta", 
                  model.file = "jags/Rate_3.jags",
                  n.chains=2, n.iter=20000, 
                  n.burnin=1, n.thin=1, DIC=T)
r3jagsfit
