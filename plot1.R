## This script read the file "household_power_consumption.txt" and produce
## the plot1 of "Peer-graded Assignment: Course Project 1"
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

## plot1
png(filename = "plot1.png", width = 480, height = 480)
hist(MyData$Global_active_power, xlab = "Global active power (kilowatts)", col="red", main = "Global active power" )
dev.off()

## system.time(source("plot1.R"))
##    user  system elapsed 
##  58.552  13.420  71.945 
