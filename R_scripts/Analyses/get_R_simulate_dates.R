r_sim_dates <- oxcal_out[grep("R_Simulate\\(",oxcal_out)]
r_sim_dates <- str_extract_all(r_sim_dates,"[0-9]+")
getRSimdates <- function(x){
   return(as.numeric(x[5]))
}
r_sim_dates <- unlist(lapply(r_sim_dates,getRSimdates))
r_sim_dates <- oxcalRSimulate(data.frame(Name=c(1:length(r_sim_dates)),
                                          Date=r_sim_dates,
                                          Uncertainty=rep(50,length(r_sim_dates))))
write.csv(r_sim_dates,
         file="../Data/Simulated/simulated_dates_regression_oxal_rsim.csv",
         row.names=F,
         quote=F)
