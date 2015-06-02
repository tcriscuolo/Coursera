data <- read.csv(file = "data.csv", header = TRUE);

png(file = "plot4.png")
par(mfrow = c(2,2));

plot(data$DateTime, data$Global_active_power, xlab = "",
     ylab = "Global Active Power")
lines(data$DateTime, data$Global_active_power, lwd = 1)


plot(data$DateTime, data$Voltage, xlab = "",
     ylab = "Voltage")
lines(data$DateTime, data$Voltage, lwd = 1)


plot(data$DateTime, data$Sub_metering_1, xlab = "",
     ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_1, lwd = 1)
lines(data$DateTime, data$Sub_metering_2, lwd = 1, col = "red")
lines(data$DateTime, data$Sub_metering_3, lwd = 1, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

plot(data$DateTime, data$Global_reactive_power, xlab = "",
     ylab = "Global Reactive Power")
lines(data$DateTime, data$Global_reactive_power, lwd = 1)

dev.off()