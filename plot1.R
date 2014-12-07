
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


# Plot --------------------------------------------------------------------
png("plot1.png", width = 480, height = 480)
hist(data2$Global_active_power
     , col=c("red")
     , xlab = "Global Active Power (kilowatts)"
     , main = "Global Active Power"
)
dev.off()


