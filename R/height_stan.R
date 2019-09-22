

library(rstan)

# to be passed on to Stan
data <- read_rdump("data/height.data.R") 

myinits <- list(
  list(mu = c(50, 75)),  # chain 1 starting value
  list(sigma = c(1,8)))  # chain 2 starting value

# parameters to be monitored:  
parameters <- c("mu", "sigma")

# The following command calls Stan with specific options.
# For a detailed description type "?rstan".
samples <- stan(file="stan/height.stan",   
                data=data, 
               # init=myinits,  # If not specified, gives random inits
                pars=parameters,
                iter=2000, 
                chains=2, 
                thin=1,
                # warmup = 100,  # Stands for burn-in; Default = iter/2
                # seed = 123  # Setting seed; Default is random seed
)
