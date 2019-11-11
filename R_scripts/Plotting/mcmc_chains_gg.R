#load("../Results/mcmc_gamma_spdf_ar.RData")
#df <- #as.data.frame(samples[50000:dim(samples)[1],grep("B|alpha0|r|rho|sigma",colnames(samples))]#)
df <- as.data.frame(samples[50000:dim(samples)[1],c(1,402)])
df$index <- 1:dim(df)[1]
p1 <- ggplot(data=df,aes(y=B,x=index)) +
geom_line() +
labs(y=expression(beta)) +
#scale_x_continuous(breaks=seq(0,length(sampleindex),100000)) +
theme_minimal() +
theme(text = element_text(family="Times", size=12),
      plot.title = element_text(face="bold",hjust=0.5,size=15),
      axis.title.x = element_blank())

p2 <- ggplot(data=df,aes(y=alpha0,x=index)) +
geom_line() +
labs(y=expression(alpha[0])) +
#scale_x_continuous(breaks=seq(0,length(sampleindex),100000)) +
theme_minimal() +
theme(text = element_text(family="Times", size=12),
      plot.title = element_text(face="bold",hjust=0.5,size=15),
      axis.title.x = element_blank())

p3 <- ggplot(data=df,aes(y=r,x=index)) +
geom_line() +
labs(y=expression(r)) +
#scale_x_continuous(breaks=seq(0,length(sampleindex),100000)) +
theme_minimal() +
theme(text = element_text(family="Times", size=12),
      plot.title = element_text(face="bold",hjust=0.5,size=15),
      axis.title.x = element_blank())

p4 <- ggplot(data=df,aes(y=rho,x=index)) +
geom_line() +
labs(y=expression(rho)) +
#scale_x_continuous(breaks=seq(0,length(sampleindex),100000)) +
theme_minimal() +
theme(text = element_text(family="Times", size=12),
      plot.title = element_text(face="bold",hjust=0.5,size=15),
      axis.title.x = element_blank())

p5 <- ggplot(data=df,aes(y=sigma,x=index)) +
geom_line() +
labs(y=expression(sigma)) +
#scale_x_continuous(breaks=seq(0,length(sampleindex),100000)) +
theme_minimal() +
theme(text = element_text(family="Times", size=12),
      plot.title = element_text(face="bold",hjust=0.5,size=15),
      axis.title.x = element_blank())

fig <- ggarrange(p1,p2,p3,p4,p5,
                  ncol=1,
                  nrow=5,
                  align="v")

annotate_figure(fig,
               left = text_grob("Value",
                                 family="Times New Roman",
                                 rot=90),
               bottom = text_grob("Sample",
                                 family="Times New Roman"),
               top = text_grob("MCMC Chains",
                                 family="Times New Roman",
                                 face="bold"),
               fig.lab.pos = "top")

ggsave(filename=paste("../Images/mcmcchains_spdf_exp.png",sep=""),
      width=10,
      height=10,
      units="cm",
      scale=2,
      device = "png",
      dpi=600)
