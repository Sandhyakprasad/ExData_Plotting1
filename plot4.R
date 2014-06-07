#Plot4
# Read a subset of data from the file "household_power_consumption.txt" 
# for the Dates 01/02/2007 & 02/02/2007

library(sqldf)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip")

energyData <- read.csv.sql("household_power_consumption.txt",
                                    sql="select * from file where Date in('1/2/2007','2/2/2007') ",
                                    header=TRUE,sep=";",eol="\n")

#Date - Time Conversion from character to "Date" format and "POSIXlt"/"POSIXct"  

energyData$dateTime <- paste(energyData$Date,energyData$Time)
energyData$dateTime  <- strptime(energyData$dateTime,format="%d/%m/%Y %H:%M:%S")

# Save the plot to PNG file "plot4.png"
png(filename ="plot4.png",width=480,height=480)

# Plot the required 4 plots
#Plot1 

par(mfrow=c(2,2),mar=c(4,4,1,1))
with(energyData,plot(dateTime,Global_active_power,type="l",
                     xlab="",ylab="Global Active Power"))

#Plot2
with(energyData,plot(dateTime,Voltage,type="l",xlab="datetime",ylab="Voltage"))

#Plot3

with(energyData,plot(dateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))

with(energyData,lines(dateTime,Sub_metering_2,type="l",col="red"))

with(energyData,lines(dateTime,Sub_metering_3,type="l",col="blue"))

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",
       lty=c(1,1,1),col=c(1,2,4),cex=0.8)

#Plot4

with(energyData,plot(dateTime,Global_reactive_power,type="l",
                     xlab="datetime",ylab="Global_reactive_power"))
dev.off()

