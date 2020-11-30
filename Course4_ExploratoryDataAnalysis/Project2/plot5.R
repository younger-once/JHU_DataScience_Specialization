#read in data file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find row indices for sources (SCC) associated with motor vehicles in SCC data frame
# using Short.Name column, searching for term "veh" as proxy for motor vehicle
mv <- grep("veh",tolower(SCC$Short.Name))

# subset of NEI data frame with motor vehicles in Baltimore
NEI_mv_balt <- merge(subset(NEI,fips == "24510"), SCC[mv,], by = "SCC")

# plot
ggplot(NEI_mv_balt, aes(year,Emissions)) + 
  stat_summary(fun=sum,geom="line", color="orange") +
  stat_summary(fun=sum,geom="point",color="orange") +
  theme_classic() +
  labs(y= "tons", title = "Baltimore City, MD PM2.5 Motor Vehicle Emissions by Year") + 
  scale_x_continuous(breaks = seq(1999,2008,3)) +
  ylim(0,400)

#save plot
ggsave('plot5.png')

# turn off graphical device
dev.off()

