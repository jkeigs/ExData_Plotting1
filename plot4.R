
# Import Data -------------------------------------------------------------
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

temp <- tempfile()
download.file(fileURL, temp, method = "curl")
# data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE)
data <- read.csv(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";")


# Filter Data for relevant dates ------------------------------------------
library(lubridate)
data$Date <- dmy(data$Date)

data2 <- data %>% filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))


# Munge Data Formats ------------------------------------------------------
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))
data2$Sub_metering_1 <- as.numeric(as.character(data2$Sub_metering_1))
data2$Sub_metering_2 <- as.numeric(as.character(data2$Sub_metering_2))
data2$Sub_metering_3 <- as.numeric(as.character(data2$Sub_metering_3))
data2$Voltage <- as.numeric(as.character(data2$Voltage))
data2$Global_reactive_power <- as.numeric(as.character(data2$Global_reactive_power))


# Plot 4 ------------------------------------------------------------------
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
## Plot1 - Mirrors plot 2 from assignment
#Create line chart
plot (c(1,nrow(data2)),c(0,8),type="n", ann = FALSE, xaxt = "n", yaxt = "n") # sets the x and y axes scales'
lines(data2$Global_active_power, type="l")
#add x-axis labels
axis(1, at=c(1,nrow(data2)/2, nrow(data2)), lab=c("Thu", "Fri", "Sat"))
#add y-axis labels
axis(2, at=c(0,2,4,6), lab=c(0,2,4,6))
#add title for y axis
title(ylab = "Global Active Power (kilowatts)")

## Plot 2
plot(c(1,nrow(data2)), c(230,250), type="n", ann=FALSE, xaxt = "n")
lines(data2$Voltage, type="l")
axis(1, at=c(1,nrow(data2)/2, nrow(data2)), lab=c("Thu", "Fri", "Sat"))
title(xlab = "datetime")


## Plot 3 - Mirrors plot 3 from assignment
plot (c(1,nrow(data2)),c(0,40),type="n", ann = FALSE, xaxt = "n", yaxt="n") # sets the x and y axes scales'
legend("topright"
       , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , lty=c(1,1,1)
       , col=c("black", "red", "blue")
       , xjust = 1)
lines(data2$Sub_metering_1, type="l")
lines(data2$Sub_metering_2,type = "l", col = "red")
lines(data2$Sub_metering_3,type = "l", col = "blue")
#add x-axis labels
axis(1, at=c(1,nrow(data2)/2, nrow(data2)), lab=c("Thu", "Fri", "Sat"))
# add y-axix labels
axis(2, at=c(0, 10, 20, 30), lab=c(0,10,20,30))
#add title for y axis
title(ylab = "Energy sub metering")

## Plot 4
plot(c(1,nrow(data2)), c(0,0.5), type="n", ann=FALSE, xaxt = "n")
lines(data2$Global_reactive_power, type="l")
axis(1, at=c(1,nrow(data2)/2, nrow(data2)), lab=c("Thu", "Fri", "Sat"))
title(xlab = "datetime"
      , ylab = "Global_reactive_power")
dev.off()