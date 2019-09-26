#**************************************************************************
# Title: SpeededChoiceSimulation.R
# Author: William Murrah
# Description: Speeded Choice simulation from chapter 2 of Farrell and 
#              Lewandowsky 2018.
# Created: Wednesday, 25 September 2019
# R version: R version 3.6.1 (2019-07-05)
# Directory: /home/wmmurrah/Projects/Learning/CognitiveModeling
#**************************************************************************
# packages used -----------------------------------------------------------
  
nreps <- 1e4
nsamples <- 2e3

drift <- 0.0
sdrw <- 0.3
criterion <- 3

latencies <- rep(0, nreps)
responses <- rep(0, nreps)
evidence <- matrix(0, nreps, nsamples+1)
set.seed(1234)
for(i in c(1:nreps)) {
  evidence[i, ] <- 
    cumsum(c(0, rnorm(nsamples, drift, sdrw)))
  p <- which(abs(evidence[i, ]) > criterion)[1]
  responses[i] <- sign(evidence[i, p])
  latencies[i] <- p
}

# Plot up to 5 random-walk paths
tbpn <- min(nreps, 5)
plot(1:max(latencies[1:tbpn]), type = "n", las = 1,
     ylim = c(-criterion - .5, criterion + .5),
     ylab = "Evidence", xlab = "Decision time")
for(i in c(1:tbpn)) {
  lines(evidence[i, 1:(latencies[i] - 1)])
}
abline(h = c(criterion, -criterion), lty = "dashed")

#plot histograms of latencies
par(mfrow=c(2,1))
toprt <- latencies[responses>0]
topprop <- length(toprt)/nreps
hist(toprt,col="gray", breaks = "fd",
     xlab="Decision time", xlim=c(0,max(latencies)),
     main=paste("Top responses (",as.numeric(topprop),
                ") m=",as.character(signif(mean(toprt),4)),
                sep=""),las=1)
botrt <- latencies[responses<0]
botprop <- length(botrt)/nreps
hist(botrt,col="gray", breaks = "fd",
     xlab="Decision time",xlim=c(0,max(latencies)),
     main=paste("Bottom responses (",as.numeric(botprop),
                ") m=",as.character(signif(mean(botrt),4)),
                sep=""),las=1)
