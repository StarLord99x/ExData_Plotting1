## Load libraries used by this script
library(lubridate)
library(dplyr)

## Read data file into a table, then subset to just 1 and 2 Feb 2007
fname <- "household_power_consumption.txt"
projData <- read.table(fname,sep = ";",header = TRUE,na.strings = "?")
projData <- projData[projData$Date == "1/2/2007"|projData$Date == "2/2/2007",]

## Coerce $Date and $Time and combine into single date/time variable
projData <- mutate(projData,datetime = dmy(Date,tz="")+hms(Time))

png(filename = "plot4.png")
par(mfcol = c(2,2))
## Top left plot
plot(projData$datetime,projData$Global_active_power, xlab = "",
     ylab = "Global Active Power (kilowatts)", type = "n")
lines(projData$datetime,projData$Global_active_power)

## Bottom left plot
plot(projData$datetime,projData$Sub_metering_1, xlab = "",
     ylab = "Energy sub metering", type = "n")
lines(projData$datetime,projData$Sub_metering_1,col = "black")
lines(projData$datetime,projData$Sub_metering_2,col = "red")
lines(projData$datetime,projData$Sub_metering_3,col = "blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1, col = c("black","red","blue"))

## Top right plot
plot(projData$datetime,projData$Voltage, xlab = "datetime",
     ylab = "Voltage", type = "n")
lines(projData$datetime,projData$Voltage)

## Bottom right plot
plot(projData$datetime,projData$Global_reactive_power, xlab = "datetime",
     ylab = "Global_reactive_power", type = "n")
lines(projData$datetime,projData$Global_reactive_power)

dev.off()