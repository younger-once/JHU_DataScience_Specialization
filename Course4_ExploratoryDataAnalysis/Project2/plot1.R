# read in data file
NEI <- readRDS("summarySCC_PM25.rds")

# calculate total emissions by year
ttl_emis <- with(NEI, tapply(Emissions,year,sum,na.rm=TRUE))

# output plotting scripts below to png
png("plot1.png")

# plot line graph - tons rescaled per million
plot(names(ttl_emis),ttl_emis/1e6, type="l", main="Total U.S. PM2.5 Emissions by Year",
     xlab="year", ylab="tons (in millions)", col="blue",lwd=2,
     xaxt = "n", ylim = c(0,max(ttl_emis/1e6)))

# add points to emphasize that data is available in 3 year increments
points(names(ttl_emis),ttl_emis/1e6, col="blue", pch=16)  

#customize x axis
axis(side=1, at=seq(1999,2008,by=3))  

# close the plot
dev.off()
