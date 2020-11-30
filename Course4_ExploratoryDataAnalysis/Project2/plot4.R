#read in data file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find row indices for sources (SCC) associated with coal in SCC data frame
coal <- apply(SCC,1,function(x) any(grep("coal",tolower(x))))

# subset of NEI data frame with coal
NEI_coal <- merge(NEI, SCC[coal,], by = "SCC")

# plot
ggplot(NEI_coal, aes(year,Emissions/1e6)) + 
  stat_summary(fun=sum,geom="line", color="red") +
  stat_summary(fun=sum,geom="point",color="red") +
  theme_classic() +
  labs(y= "tons (millions)", title = "Total U.S.Coal PM2.5 Emissions by Year") + 
  scale_x_continuous(breaks = seq(1999,2008,3)) + 
  ylim(0,0.70)

#save plot
ggsave('plot4.png')

# turn off graphical device
dev.off()