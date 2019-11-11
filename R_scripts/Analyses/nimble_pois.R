poisHierCode <- nimbleCode({
   B0 ~ dnorm(mean=0,sd=1000)
   B ~ dnorm(mean=0,sd=1000)
   for (n in 1:N) {
      u[n] <- B0 + X[n] * B
      Y[n] ~ dpois(exp(u[n]))
   }
})

X <- regression_eval_df$Covariate
Y <- regression_eval_df$Count
N <- length(Y)

poisHierData <- list(Y=Y,
                  X=X)

poisHierConsts <- list(N=N)

poisHierInits <- list(B=0)

poisHierModel <- nimbleModel(code=poisHierCode,
                        data=poisHierData,
                        inits=poisHierInits,
                        constants=poisHierConsts)

#compile nimble model to C++ code—much faster runtime
C_poisHierModel <- compileNimble(poisHierModel, showCompilerOutput = FALSE)

#configure the MCMC
poisHierModel_conf <- configureMCMC(poisHierModel)

#select the variables that we want to monitor in the MCMC chain
poisHierModel_conf$addMonitors(c("B"))

#build MCMC
poisHierModelMCMC <- buildMCMC(poisHierModel_conf,thin=1,enableWAIC = TRUE)

#compile MCMC to C++—much faster
C_poisHierModelMCMC <- compileNimble(poisHierModelMCMC,project=poisHierModel)

#number of MCMC iterations
niter=500000

#set seed for replicability
set.seed(1)

#call the C++ compiled MCMC model
C_poisHierModelMCMC$run(niter)

#save the MCMC chain (monitored variables) as a matrix
samples <- as.matrix(C_poisHierModelMCMC$mvSamples)
