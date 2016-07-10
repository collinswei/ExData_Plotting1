# set your work directory(pls change this parth as your own)

setwd("~/data")

# create work file

#if (!file.exists("ExData_Plotting1")) {
#       dir.create("ExData_Plotting1")
#}

setwd("~/data/ExData_Plotting1")

#download source data file

#fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(fileurl, destfile = "housepower.zip", method = "curl")
#unzip("housepower.zip")

# read data

housepowerdata<-read.table("household_power_consumption.txt",header = TRUE, sep= ";",na.strings = "?")

#  convert the Date and Time variables to Date/Time classes

housepowerdata$DateTime<-paste(housepowerdata$Date, housepowerdata$Time)

housepowerdata$DateTime<-strptime(housepowerdata$DateTime, "%d/%m/%Y %H:%M:%S")

starttime <- which(housepowerdata$DateTime == strptime("2007-02-01", "%Y-%m-%d"))
endtime <- which(housepowerdata$DateTime == strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

targetdataset <- housepowerdata[starttime:endtime, ]

png(filename = './plot4.png', width = 480, height = 480, units='px')

subindex <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
linecolor <- c("black","red","blue")
par(mfrow=c(2,2))
plot(targetdataset$DateTime, targetdataset$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(targetdataset$DateTime, targetdataset$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
plot(targetdataset$DateTime, targetdataset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(targetdataset$DateTime, targetdataset$Sub_metering_2, type="l", col="red")
lines(targetdataset$DateTime, targetdataset$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=subindex, lty=1, col=linecolor)
plot(targetdataset$DateTime, targetdataset$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")

dev.off()