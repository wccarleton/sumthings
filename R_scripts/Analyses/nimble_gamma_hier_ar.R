gammaHierCode <- nimbleCode({
   ###top-level regression
   B ~ dnorm(mean=0,sd=1000)
   sigB ~ dunif(1e-7,100)
   for (k in 1:K) {
      ###low-level regression
      r[k] ~ dexp(0.01)
      b[k] ~ dnorm(mean=B,sd=sigB)
      ###autocorrelation part
      sigma[k] ~ dexp(0.75)
      rho[k] ~ dnorm(mean=0,sd=10)
      alpha0[k] ~ dnorm(mean=0,sd=10)
      alpha[1,k] ~ dnorm(rho[k] * alpha0[k],sd=sigma[k])
      for (n in 2:N){
         alpha[n,k] ~ dnorm(rho[k] * alpha[n-1,k],sd=sigma[k])
      }
      for (n in 1:N) {
         lambda[n,k] <- exp(alpha[n,k] + X[n] * b[k])
         Y[n,k] ~ dgamma(r[k],r[k]/lambda[n,k])
      }
   }
})

X <- regression_eval_df$Covariate
Y <- kde_ensemble_unscaled[,sample(1:ncol(kde_ensemble_unscaled),100)]
N <- nrow(Y)
K <- ncol(Y)

gammaHierData <- list(Y=Y,
                  X=X)

gammaHierConsts <- list(N=N,
                     K=K)

gammaHierInits <- list(B=0,
                        sigB=1,
                        b=rep(0,K),
                        alpha0=rep(1,K),
                        rho=rep(1,K),
                        r=rep(1,K),
                        alpha=matrix(1,ncol=K,nrow=N))

gammaHierModel <- nimbleModel(code=gammaHierCode,
                        data=gammaHierData,
                        inits=gammaHierInits,
                        constants=gammaHierConsts)

#compile nimble model to C++ code—much faster runtime
C_gammaHierModel <- compileNimble(gammaHierModel, showCompilerOutput = FALSE)

#configure the MCMC
gammaHierModel_conf <- configureMCMC(gammaHierModel)

#select the variables that we want to monitor in the MCMC chain
gammaHierModel_conf$addMonitors(c("b"))#,"alpha","alpha0"))

#build MCMC
gammaHierModelMCMC <- buildMCMC(gammaHierModel_conf,thin=9,enableWAIC = TRUE)

#compile MCMC to C++—much faster
C_gammaHierModelMCMC <- compileNimble(gammaHierModelMCMC,project=gammaHierModel)

#number of MCMC iterations
niter=500000

#set seed for replicability
set.seed(1)

#call the C++ compiled MCMC model
C_gammaHierModelMCMC$run(niter)

#save the MCMC chain (monitored variables) as a matrix
samples <- as.matrix(C_gammaHierModelMCMC$mvSamples)
