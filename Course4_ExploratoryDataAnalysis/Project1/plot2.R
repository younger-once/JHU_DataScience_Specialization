# bring in custom function to read file
source("read_file_function.R")

# read in household power consumption file
f <- read_household_file()

# create plot 2, save as png
png(filename="plot2.png",height=480,width=480)

with(f,plot(DateTime, Global_active_power, type="l", lwd = 1.25, 
            xlab = "", ylab="Global Active Power (kilowatts)"))

dev.off()
