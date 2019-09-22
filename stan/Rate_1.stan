// Inferring a Rate
data { 
  int<lower=1> n; 
  int<lower=0> k;
  int<lower=0> beta_prior_shape1;
  int<lower=0> beta_prior_shape2;
} 
parameters {
  real<lower=0,upper=1> theta;
} 
model {
  // Prior Distribution for Rate Theta
  theta ~ beta(beta_prior_shape1, beta_prior_shape2);
  
  // Observed Counts
  k ~ binomial(n, theta);
}
