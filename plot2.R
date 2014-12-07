
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


# Plot 2 ------------------------------------------------------------------
png("plot2.png", width = 480, height = 480)
#Create line chart
plot (c(1,nrow(data2)),c(0,8),type="n", ann = FALSE, xaxt = "n", yaxt = "n") # sets the x and y axes scales'
lines(data2$Global_active_power, type="l")
#add x-axis labels
axis(1, at=c(1,nrow(data2)/2, nrow(data2)), lab=c("Thu", "Fri", "Sat"))
#add y-axis labels
axis(2, at=c(0,2,4,6), lab=c(0,2,4,6))
#add title for y axis
title(ylab = "Global Active Power (kilowatts)")
dev.off()