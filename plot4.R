## This script read the file "household_power_consumption.txt" and produce
## the plot4 of "Peer-graded Assignment: Course Project 1"
## of the course "exploratory data analysis"

## Read data:
PowerConsumptionData <- read.csv2("household_power_consumption.txt",na.strings="?", colClasses = "character")

## Transform character in POSIXlt
DateTime <- strptime(paste(PowerConsumptionData$Date, PowerConsumptionData$Time), "%d/%m/%Y %H:%M:%S" )

## Remove first two col and add new Date/Time variable
PowerConsumptionData  <- cbind(DateTime, PowerConsumptionData[-c(1,2)])

## Extract only Data I need for this analysis
MyData <- PowerConsumptionData[ DateTime >="2007-02-01" & DateTime <="2007-02-03", ]

## Checked the presence of na: sum(good <- is.na(MyData)) but itis zero!


## Functio to coerce char in num
CoerceCharToNum <- function(data){
    for(i in 2:ncol(data)){
        data[[i]] <- as.numeric(data[[i]])
    }
    data
}

## Corce MyData
MyData <- CoerceCharToNum(MyData)

## plot4
png(filename = "plot4.png", width = 480, height = 480)

## set the canvas
par(mfcol=c(2,2), mar=c(4,4,1,1), oma=c(0,0,0,0))

##plot(1,1)
plot(MyData$DateTime,MyData$Global_active_power, type="l", xlab = "", ylab = "Global active power" )

##plot(2,1)
plot(MyData$DateTime, MyData$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(MyData$DateTime, MyData$Sub_metering_1, col="black")
lines(MyData$DateTime, MyData$Sub_metering_2, col="red")
lines(MyData$DateTime, MyData$Sub_metering_3, col="blue")
legend("topright", col = c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ), lty=c(1,1,1))

##plot(1,2)
plot(MyData$DateTime, MyData$Voltage, type="l", xlab="datetime", ylab = "Voltage")

##plot(2,2)
plot(MyData$DateTime, MyData$Global_reactive_power, type="l", xlab="datetime", ylab = "Global_reactive_power")

## close device
dev.off()

## system.time(source("plot4.R"))
##    user  system elapsed 
##  58.940  13.164  72.439 
