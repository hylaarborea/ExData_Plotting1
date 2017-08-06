## This script read the file "household_power_consumption.txt" and produce
## the plot3 of "Peer-graded Assignment: Course Project 1"
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

## plot3
png(filename = "plot3.png", width = 480, height = 480)
plot(MyData$DateTime, MyData$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(MyData$DateTime, MyData$Sub_metering_1, col="black")
lines(MyData$DateTime, MyData$Sub_metering_2, col="red")
lines(MyData$DateTime, MyData$Sub_metering_3, col="blue")
legend("topright", col = c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ), lty=c(1,1,1))
dev.off()

## system.time(source("plot3.R"))
##    user  system elapsed 
##  59.040  13.160  72.345
