#Plot3
# Read a subset of data from the file "household_power_consumption.txt" 
# for the Dates 01/02/2007 & 02/02/2007

library(sqldf)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip")

electricConsumption <- read.csv.sql("household_power_consumption.txt",
                                sql="select * from file where Date in('1/2/2007','2/2/2007') ",
                                header=TRUE,sep=";",eol="\n")

#Date - Time Conversion from character to "Date" format and "POSIXlt"/"POSIXct"  

electricConsumption$dateTime <- paste(electricConsumption$Date,electricConsumption$Time)
electricConsumption$dateTime  <- strptime(electricConsumption$dateTime,format="%d/%m/%Y %H:%M:%S")

# Save the plot to PNG file "plot3.png"
png(filename ="plot3.png",width=480,height=480)


# Plot the line graph with dateTime on x axis and Sub_metering_1,Sub_metering_2,
# Sub_metering_3 on y axis

with(electricConsumption,plot(dateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))

with(electricConsumption,lines(dateTime,Sub_metering_2,type="l",col="red"))

with(electricConsumption,lines(dateTime,Sub_metering_3,type="l",col="blue"))

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c(1,2,4),cex=1)

dev.off()