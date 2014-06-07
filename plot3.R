## Read in data
setwd("~/Dropbox/R/Exploratory")
dat <- read.table("~/Dropbox/R/Exploratory/household_power_consumption.txt", sep=";",
                  header=TRUE, stringsAsFactors=FALSE)

#subset data for 2 days we are looking for
dat <- subset(dat, Date == "1/2/2007" | Date == "2/2/2007")

## convert Date columns to actual date and time info using paste of date and time from original
dat$Date <- as.POSIXct(strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S"))
## convert data to numeric
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)

## open device for output
out <- png("plot3.png")
plot(dat$Date, dat$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
points(dat$Date, dat$Sub_metering_1, col="black", type="l")
points(dat$Date, dat$Sub_metering_2, col="red", type="l")
points(dat$Date, dat$Sub_metering_3, col="blue", type="l")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=1)
dev.off()