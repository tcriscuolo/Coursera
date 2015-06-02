data <- read.csv(file = "data.csv", header = TRUE);

png(file = "plot3.png")

plot(data$DateTime, data$Sub_metering_1, xlab = "",
     ylab = "Energy sub metering")

lines(data$DateTime, data$Sub_metering_1, lwd = 1)
lines(data$DateTime, data$Sub_metering_2, lwd = 1, col = "red")
lines(data$DateTime, data$Sub_metering_3, lwd = 1, col = "blue")

legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

dev.off()