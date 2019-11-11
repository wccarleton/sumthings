#load("../Results/mcmc_gamma_spdf_ar.RData")
my_density <- function (data, mapping, ...)
{
   rangeX <- range(eval_data_col(data, mapping$x), na.rm = TRUE)
   rangeY <- range(eval_data_col(data, mapping$y), na.rm = TRUE)
   p <- ggplot(data = data,
               mapping=mapping) +
         geom_point(alpha = 0.01,
                     size = 1)
   p
}

#df <- #as.data.frame(samples[50000:dim(samples)[1],grep("B|alpha0|r|rho|sigma",colnames(samples))]
df <- as.data.frame(samples[50000:dim(samples)[1],]) ###this line for the KDE #ensemble model
ggpairs(df,
         lower = list(continuous = my_density),
         columnLabels=c("beta",
                        "beta[0]"),
                        #"r",
                        #"rho",
                        #"sigma[b]"),
         labeller="label_parsed") +
theme_minimal() +
theme(text = element_text(family="Times", size=12),
      plot.title = element_text(face="bold",hjust=0.5,size=15))

ggsave(filename=paste("../Images/pairs_pois.png",sep=""),
      device = "png",
      height = 20,
      width = 20,
      units = "cm",
      scale = 1.25,
      dpi = 1000)
