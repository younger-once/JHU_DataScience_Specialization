# bring in custom function to read file
source("read_file_function.R")

# read in household power consumption file
f <- read_household_file()

# create plot 1, save output as png
png(filename="plot1.png",height=480,width=480)

hist(f$Global_active_power, col='red', xlab="Global Active Power (kilowatts)", main="Global Active Power")
axis(2, at=seq(0,1200,400))

dev.off()
