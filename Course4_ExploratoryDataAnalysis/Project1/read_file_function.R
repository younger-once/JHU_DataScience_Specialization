# install libraries  (if necessary) and load into environment
if (!require("pacman")) install.packages("pacman")
pacman::p_load(sqldf,dplyr,magrittr)

# custom function to read in household power consumption data
read_household_file <- function (fname = "household_power_consumption.txt") {

  # read in data-- only bring two dates needed for analysis
  myfile <- read.csv.sql(fname, sql = "select * from file where Date IN ('1/2/2007','2/2/2007')",
                    sep = ";",colClasses = c(rep("character",2),rep("numeric",7)))
  
  # add new POSIX variable, DateTime, in data frame 
  myfile %<>% mutate(DateTime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S",tz="UTC"))
  
  myfile
}


