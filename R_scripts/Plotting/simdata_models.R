x1 <- -200
x2 <- 500
p1 <- ggplot()
ticker <- 0
for(j in kde_ensembles){
   ticker <- ticker + 1
   df <- data.frame(Date = j[,1], Density = j[,2] * kde_prNorms[ticker])
   p1 <- p1 + geom_path(data=df, mapping=aes(x=Date,y=Density),alpha=0.8,colour="lightblue")
}
df <- data.frame(Date=kdepost$Date,Density=kdepost$Density * (kdepost_prNorm * 450))
p1 <- p1 + geom_line(data = df, mapping=aes(x=Date,y=Density))
p1 <- p1 + xlim(x1,x2)
#p1 <- p1 + ylim(0,1.5)
p1 <- p1 + theme_minimal()
p1 <- p1 + theme(text = element_text(family="Times", size=12),
               axis.title.x=element_blank(),
               axis.text.x=element_blank(),
               axis.ticks.x=element_blank())
annotation_y <- ggplot_build(p1)$layout$panel_scales_y[[1]]$range$range[2] * 0.95
p1 <- p1 + annotate("text",
                     x=x2,
                     y=annotation_y,
                     label="KDE Model",
                     family="Times",
                     size=3,
                     hjust=1)

###cal curve
p4 <- ggplot(data=cal_curve_df,aes(x=BCAD)) +
      geom_ribbon(mapping=aes(ymin = RCBP_l, ymax = RCBP_u),
                  fill="steelblue",
                  alpha=0.5) +
      geom_line(data=cal_curve_df,
                  mapping=aes(y=RCBP, x=BCAD),
                  size=0.1) +
      ylim(1300,2400) +
      xlim(x1,x2) +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12),
               axis.title.x=element_blank(),
               axis.text.x=element_blank(),
               axis.ticks.x=element_blank(),
               plot.subtitle=element_text(size=8,hjust=1))
annotation_y <- ggplot_build(p4)$layout$panel_scales_y[[1]]$range$range[2] * 0.95
p4 <- p4 + annotate("text",
                     x=x2,
                     y=annotation_y,
                     family="Times",
                     label="Calibration Curve",
                     size=3,
                     hjust=1)

###Sum
p5 <- ggplot()
p5 <- p5 + geom_area(data=sumpost,mapping=aes(y=Density,x=Date),fill="grey",alpha=0.75)
p5 <- p5 + xlim(x1,x2)
p5 <- p5 + theme_minimal()
p5 <- p5 + theme(text = element_text(family="Times", size=12),
               axis.title.x=element_blank(),
               axis.text.x=element_blank(),
               axis.ticks.x=element_blank())
annotation_y <- ggplot_build(p5)$layout$panel_scales_y[[1]]$range$range[2] * 0.95
p5 <- p5 + annotate("text",
                     x=x2,
                     y=annotation_y,
                     family="Times",
                     label="SPDF",
                     size=3,
                     hjust=1)

###CountData
p6 <- ggplot(data = regression_eval_df) +
      geom_col(aes(x=Date,y=Count)) +
      xlim(x1,x2) +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12),
                     axis.title.x=element_blank(),
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank())
annotation_y <- ggplot_build(p6)$layout$panel_scales_y[[1]]$range$range[2] * 0.95
p6 <- p6 + annotate("text",
                     x=x2,
                     y=annotation_y,
                     family="Times",
                     label="Count Time Series",
                     size=3,
                     hjust=1)

###Covariate
p7 <- ggplot(data = regression_eval_df) +
      geom_line(mapping=aes(x=Date,y=Covariate),size=0.25) +
      xlim(x1,x2) +
      labs(y="Value")+
      theme_minimal() +
      theme(text = element_text(family="Times", size=12))
annotation_y <- ggplot_build(p7)$layout$panel_scales_y[[1]]$range$range[2] * 0.95
p7 <- p7 + annotate("text",
                     x=x2,
                     y=annotation_y,
                     family="Times",
                     label="Covariate",
                     size=3,
                     hjust=1)

fig <- ggarrange(p4,p5,p1,p6,p7,
         ncol=1,
         nrow=5,
         align="v")
#annotate_figure(fig,
#               top=text_grob("Simulated Data and Models",family="Times",face="bold"),
#               bottom=text_grob("Calendar Date BCE/CE",family="Times",face="bold"))
fig
ggsave(filename="../Images/simdata_models.png",
      device = "png",
      height = 10,
      width = 10,
      units = "cm",
      scale = 1.5,
      dpi = 2000)
