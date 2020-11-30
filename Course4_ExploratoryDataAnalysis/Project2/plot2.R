# read in data file
NEI <- readRDS("summarySCC_PM25.rds")

# subset NEI to include Baltimore, MD only
baltimore <- subset(NEI,fips == "24510")

# calculate total emissions by year for Baltimore
ttl_emis <- with(baltimore, tapply(Emissions,year,sum,na.rm=TRUE))

# output plotting scripts below to png
png("plot2.png")

# plot line graph
plot(names(ttl_emis),ttl_emis, type="l", main="Baltimore City, MD PM2.5 Emissions by Year",
     xlab="year", ylab="tons", col="darkgreen",lwd=2,
     xaxt = "n",ylim = c(0,max(ttl_emis)))

# add points to emphasize that data is available in 3 year increments
points(names(ttl_emis),ttl_emis, col="darkgreen", pch=16)  

#customize x axis
axis(side=1, at=seq(1999,2008,by=3))  

# close the plot
dev.off()
