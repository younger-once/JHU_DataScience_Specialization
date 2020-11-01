# download and unzip files
myurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(myurl, "Dataset.zip"); unzip("Dataset.zip")

# data file
myfile <- "household_power_consumption.txt"

# print estimate of of full file object size by extrapolating from first n_sample rows: 151.5 Mb
n_total <- 2075259 # total rows in data frame
n_sample <- 100000 # number of sample rows to read in 
print(object.size(read.table(myfile, sep=";", header = T, nrow=n_sample))* (n_total/n_sample),units="Mb") 
