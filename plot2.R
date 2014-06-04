#Plot2
# Read a subset of data from the file "household_power_consumption.txt" 
# for the Dates 01/02/2007 & 02/02/2007

library(sqldf)
consumptionData <- read.csv.sql("household_power_consumption.txt",
                             sql="select * from file where Date in('1/2/2007','2/2/2007') ",
                             header=TRUE,sep=";",eol="\n")

#Date - Time Conversion from character to "Date" format and "POSIXlt"/"POSIXct"  

consumptionData$dateTime <- paste(consumptionData$Date,consumptionData$Time)
consumptionData$dateTime  <- strptime(consumptionData$dateTime,format="%d/%m/%Y %H:%M:%S")

# Save the plot to PNG file "plot2.png"
png(filename ="plot2.png",width=480,height=480)

# Plot the line graph with dateTime on x axis and Global_active_Power on y axis
with(consumptionData,plot(dateTime,Global_active_power,
     type="l",xlab="",ylab="Global Active Power(kilowatts)"))

dev.off()