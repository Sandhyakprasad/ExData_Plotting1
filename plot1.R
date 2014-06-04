#Plot1
# Read a subset of data from the file "household_power_consumption.txt" 
# for the Dates 01/02/2007 & 02/02/2007

library(sqldf)
electricData <- read.csv.sql("household_power_consumption.txt",
                             sql="select * from file where Date in('1/2/2007','2/2/2007') ",
                             header=TRUE,sep=";",eol="\n")
 
# Save the plot to PNG file "plot1.png"
png(filename ="plot1.png",width=480,height=480)

#Plotting the Histogram
with(electricData,hist(Global_active_power,
                       main=("Global Active Power"),
                       xlab="Global Active Power(kilowatts)",col="red"))

dev.off()