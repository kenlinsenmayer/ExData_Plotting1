## Read in data
setwd("~/Dropbox/R/Exploratory")
dat <- read.table("~/Dropbox/R/Exploratory/household_power_consumption.txt", sep=";",
                  header=TRUE, stringsAsFactors=FALSE)

#subset data for 2 days we are looking for
dat <- subset(dat, Date == "1/2/2007" | Date == "2/2/2007")

## convert Date columns to actual date and time info using paste of date and time from original
dat$Date <- as.POSIXct(strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S"))

dat$Global_active_power <- as.numeric(dat$Global_active_power)

out <- png("plot1.png")
hist(dat$Global_active_power, xlab = "Global Active Power (killowatts)",
     main = "Global Active Power", col = "Red")
dev.off()