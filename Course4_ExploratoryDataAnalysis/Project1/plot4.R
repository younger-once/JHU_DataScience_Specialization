# bring in custom function to read file
source("read_file_function.R")

# read in household power consumption file
f <- read_household_file()

# create plot 4, save as png
png(filename="plot4.png",height=480,width=480)

# make 2 x 2 plot
par(mfrow = c(2,2))

# subplot 1
with(f,plot(DateTime, Global_active_power, type="l",xlab = "", ylab="Global Active Power (kilowatts)"))

# subplot 2
with(f,plot(DateTime, Voltage, type="l",xlab = "datetime"))

# subplot plot 3
with(f, plot(DateTime,Sub_metering_1, type = "l", lwd=1.25, ylab = "Energy sub metering"))
with(f,lines(DateTime,Sub_metering_2, col ="red"))
with(f,lines(DateTime,Sub_metering_3, col ="blue"))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),lty =1, bty="n")

# subplot plot 4
with(f,plot(DateTime, Global_reactive_power, type="l",lwd = 1.25,xlab = "datetime"))

dev.off()