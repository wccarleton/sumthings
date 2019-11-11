samples_df <- data.frame(B=samples[10000:dim(samples)[1],1])
samples_df$Iteration <- 1:dim(samples_df)[1]
p1 <- ggplot(data = samples_df) +
      geom_density(mapping=aes(x=B),colour=NA,fill="grey",alpha=0.75) +
      xlim(-2e-06,2e-06) +
      labs(x=expression(beta),
            y="Density",
            title="Regression Coefficient Posterior") +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12),
            plot.title = element_text(hjust = 0.5))

p1

ggsave(filename="../Images/mcmc_results_gamma_hier.png",
      device = "png",
      height = 5,
      width = 5,
      units = "cm",
      scale = 2,
      dpi = 1000)
