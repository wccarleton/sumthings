p1 <- ggplot(data = uncal_dens) +
      geom_area(aes(x=Date,y=Density),size=0.25,alpha=0.5) +
      labs(x="Date (Uncalibrated)") +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12))
p2 <- ggplot(data = cal_dens) +
      geom_area(aes(x=Date,y=Density),size=0.25, alpha=0.5) +
      labs(x="Date (Calibrated)") +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12))

fig <- ggarrange(p1,p2,
         ncol=2,
         nrow=1,
         align="h")
annotate_figure(fig,
               top=text_grob("Example Densities",family="Times",face="bold"))
ggsave(filename="../Images/example_densities.png",
      device = "png",
      height = 5,
      width = 10,
      units = "cm",
      scale = 1.75,
      dpi = 1000)
