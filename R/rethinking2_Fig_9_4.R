# Rethinking2: Figure 9.4
D <- 1000
T <- 1e3
Y <- rmvnorm(T, rep(0, D), diag(D))
rad_dist <- function(Y) sqrt(sum(Y^2))
Rd1000 <- sapply(1:T, function(i) rad_dist(Y[i, ]))
dens(Rd10)

dens(Rd1, xlim = c(0, 40), ylim = c(0, 1), 
     xlab = "Radial distance from mode",
     ylab = "Density")
dens(Rd10, add = TRUE)
dens(Rd100, add = TRUE)
dens(Rd1000, add = TRUE)
text(x = c(1, 3, 10, 32), y = .7, labels = c("1", "10", "100", "1000"))
  

