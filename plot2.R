## Load libraries used by this script
library(lubridate)
library(dplyr)

## Read data file into a table, then subset to just 1 and 2 Feb 2007
fname <- "household_power_consumption.txt"
projData <- read.table(fname,sep = ";",header = TRUE,na.strings = "?")
projData <- projData[projData$Date == "1/2/2007"|projData$Date == "2/2/2007",]

## Coerce $Date and $Time and combine into single date/time variable
projData <- mutate(projData,datetime = dmy(Date,tz="")+hms(Time))

png(filename = "plot2.png")
plot(projData$datetime,projData$Global_active_power, xlab = "",
     ylab = "Global Active Power (kilowatts)", type = "n")
lines(projData$datetime,projData$Global_active_power)
dev.off()