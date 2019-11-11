sim_n <- 300
sim_covariate <- 0.05*c(1:sim_n) + rnorm(n=sim_n,mean=0,sd=2)
sim_b <- 0.05
sim_lambda <- exp(sim_b * sim_covariate)
sim_events <- rpois(n=sim_n,lambda=sim_lambda)
sim_years <- c(1:sim_n)
sim_reg_df <- data.frame(Date=sim_years,Lambda=sim_lambda,Count=sim_events, Covariate=sim_covariate)
write.csv(sim_reg_df,
         file="../Data/Simulated/simulated_dates_regression_dataframe.csv",
         row.names=F,
         quote=F)
sim_dates <- c()
for(j in 1:length(sim_events)){
   sim_dates <- c(sim_dates,rep(sim_years[j],sim_events[j]))
}
sim_dates_df <- data.frame(Name=seq(1:length(sim_dates)),
                           Date=sim_dates,
                           Uncertainty=rep(50,length(sim_dates)))
rm(sim_n,
   sim_b,
   sim_years,
   sim_lambda,
   sim_events,
   sim_covariate,
   sim_dates,
   j)
