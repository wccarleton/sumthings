#get kde ensemble list into DF
kde_ensemble_section <- lapply(kde_ensembles,function(x){
   x[which(x[,1] >= 1.5 & x[,1] <= 300.5),2]
})

kde_ensemble <- do.call(cbind,kde_ensemble_section)
kde_ensemble <- cbind(c(1:300),kde_ensemble)

#kdes need to be "unscaled" b/c of the way they are scaled to [0,1] in the OxCal output
kde_ensemble_unscaled <- as.matrix(kde_ensemble[,-1]) %*% diag(kde_prNorms)
