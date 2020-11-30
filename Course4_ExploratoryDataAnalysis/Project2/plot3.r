# load libraries
library(ggplot2)

# read in data file
NEI <- readRDS("summarySCC_PM25.rds")

# subset NEI to include Baltimore, MD only
baltimore <- subset(NEI,fips == "24510")

# plot
ggplot(baltimore, aes(year,Emissions, color=type)) + 
  stat_summary(fun=sum,geom="line") +
  stat_summary(fun=sum,geom="point") +
  theme_classic() +
  scale_color_brewer(type = "qual",palette=3) + 
  labs(y= "tons", title = "Baltimore City, MD PM2.5 Emissions by Year and Type") + 
  scale_x_continuous(breaks = seq(1999,2008,3))

# save plot
ggsave('plot3.png')

# turn off graphical device
dev.off()
