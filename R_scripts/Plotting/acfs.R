acf_spdf <- acf(regression_eval_df$SPDF)
acf_spdf <- data.frame(Lag=acf_spdf$lag[-1],Correlation=acf_spdf$acf[-1])
acf_kde <- acf(regression_eval_df$KDEModel)
acf_kde <- data.frame(Lag=acf_kde$lag[-1],Correlation=acf_kde$acf[-1])
p1 <- ggplot(data = acf_spdf) +
      geom_col(aes(x=Lag,y=Correlation),alpha=0.75) +
      labs(title="SPDF ACF") +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12))
p2 <- ggplot(data = acf_kde) +
      geom_col(aes(x=Lag,y=Correlation),alpha=0.75) +
      labs(title="KDE Model ACF")+
      theme_minimal() +
      theme(text = element_text(family="Times", size=12))

##PLOT
fig <- ggarrange(p1, p2,
         ncol=2,
         nrow=1,
         align="v")
fig
ggsave(filename="../Images/model_acfs.png",
      device = "png",
      height = 5,
      width = 15,
      units = "cm",
      scale = 1.5,
      dpi = 1000)
