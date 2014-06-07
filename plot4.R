## Read in data
setwd("~/Dropbox/R/Exploratory")
dat <- read.table("~/Dropbox/R/Exploratory/household_power_consumption.txt", sep=";",
                  header=TRUE, stringsAsFactors=FALSE)

#subset data for 2 days we are looking for
dat <- subset(dat, Date == "1/2/2007" | Date == "2/2/2007")

## convert Date columns to actual date and time info using paste of date and time from original
dat$Date <- as.POSIXct(strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S"))

## convert other columns to numeric
dat$Global_active_power <- as.numeric(dat$Global_active_power)
dat$Global_reactive_power <- as.numeric(dat$Global_reactive_power)
dat$Voltage <- as.numeric(dat$Voltage)
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)

## open device for output
out <- png("plot4.png")
## set up for 4 plots
par(mfrow = c(2,2))
## 1st plot
plot(dat$Date, dat$Global_active_power, type="l", ylab="Global Active Power (kilowats)", xlab="")
## 2nd plot
plot(dat$Date, dat$Voltage, type="l", xlab="datetime", ylab="Voltage")
## 3rd plot
plot(dat$Date, dat$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
points(dat$Date, dat$Sub_metering_1, col="black", type="l")
points(dat$Date, dat$Sub_metering_2, col="red", type="l")
points(dat$Date, dat$Sub_metering_3, col="blue", type="l")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=1, bty="n")
## 4th plot
plot(dat$Date, dat$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## close the file
dev.off()