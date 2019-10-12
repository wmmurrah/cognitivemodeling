#perform MCMC
burnin<- 2000

chain <- rep(0,10000)
obs <- 140
propsd <- 12     #tuning parameter
sdv <- 15

chain[1] <- 500  #starting value
for (i in 2:length(chain)) {
    current <- chain[i-1]
    proposal <- current + rnorm(1,0,propsd)
    if (dnorm(obs,proposal, sdv) > dnorm(obs,current, sdv)) { 
       chain[i] <- proposal  #accept proposal
    } else {
       chain[i] <- ifelse(runif(1) < dnorm(obs,proposal, sdv)/dnorm(obs,current,sdv),  
                          proposal, 
                          current)
    }
}  

hist(chain)
mean(chain)

par(mfrow =c(1,2))
plot(density(chain),las=1,xlab=bquote("Sampled values of "*mu),
     yaxt="n",lwd=2,lty="dashed",
     main="",xlim=c(100,200),ylab="",
     ylim=c(0,max(max(density(chain)$y),
                  max(density(chain[-c(1:burnin)])$y),
                  max(dnorm(c(100:200),144,15)))*1.4))
lines(density(chain[-c(1:burnin)]),lwd=2,lty="solid")
lines(c(100:200),dnorm(c(100:200),144,15),col="red",lwd=2)
mtext("   Density",2,1)
legend("topright",inset=.02,c("Normal PDF","All MCMC","Excluding burnin"),
       lty=c("solid","dashed","solid"),col=c("red","black","black"),lwd=2, cex = .7)


plot(chain,type="l",las=1,xlab="Iteration",ylab="Value of accepted sample")
lines(1:burnin,chain[1:burnin],col="red")

