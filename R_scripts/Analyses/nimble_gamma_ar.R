gammaCode <- nimbleCode({
   ###regression top-level
   #B0 ~ dnorm(mean=0,sd=100)
   B ~ dnorm(mean=0,sd=100)
   r ~ dexp(0.01)
   ###autocorrelation part
   sigma ~ dexp(0.75)
   rho ~ dnorm(mean=0,sd=10)
   alpha0 ~ dnorm(mean=0,sd=10)
   alpha[1] ~ dnorm(rho * alpha0,sd=sigma)
   for (n in 2:N){
      alpha[n] ~ dnorm(rho * alpha[n-1],sd=sigma)
   }
   ###linear model
   for (n in 1:N) {
      lambda[n] <- exp(alpha[n] + X[n] * B)
      Y[n] ~ dgamma(r,r/lambda[n])
   }
})

X <- regression_eval_df$Covariate
Y <- regression_eval_df$KDEModel * 1.712115 ###this normalization value provided by OxCal
N <- length(Y)

gammaData <- list(Y=Y,
                  X=X)

gammaConsts <- list(N=N)

gammaInits <- list(B=0,
                     r=1,
                     alpha0=1,
                     sigma=1,
                     rho=1)

gammaModel <- nimbleModel(code=gammaCode,
                        data=gammaData,
                        inits=gammaInits,
                        constants=gammaConsts)

#compile nimble model to C++ code—much faster runtime
C_gammaModel <- compileNimble(gammaModel, showCompilerOutput = FALSE)

#configure the MCMC
gammaModel_conf <- configureMCMC(gammaModel)

#change samplers
gammaModel_conf$removeSamplers(c('B','alpha0'))
gammaModel_conf$addSampler(target=c('B','alpha0'),type='AF_slice')

#select the variables that we want to monitor in the MCMC chain
gammaModel_conf$addMonitors(c("alpha"))

#build MCMC
gammaModelMCMC <- buildMCMC(gammaModel_conf,thin=9,enableWAIC = TRUE)

#compile MCMC to C++—much faster
C_gammaModelMCMC <- compileNimble(gammaModelMCMC,project=gammaModel)

#number of MCMC iterations
niter=500000

#set seed for replicability
set.seed(1)

#call the C++ compiled MCMC model
C_gammaModelMCMC$run(niter)

#save the MCMC chain (monitored variables) as a matrix
samples <- as.matrix(C_gammaModelMCMC$mvSamples)
