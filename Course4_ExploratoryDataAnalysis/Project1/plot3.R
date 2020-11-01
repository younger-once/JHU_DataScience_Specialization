# bring in custom function to read file
source("read_file_function.R")

# read in household power consumption file
f <- read_household_file()

# create plot 3, save as png
png(filename="plot3.png",height=480,width=480)

with(f, plot(DateTime,Sub_metering_1, type = "l", ylab = "Energy sub metering"))
with(f,lines(DateTime,Sub_metering_2, col ="red"))
with(f,lines(DateTime,Sub_metering_3, col ="blue"))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),lty =1)

dev.off()
