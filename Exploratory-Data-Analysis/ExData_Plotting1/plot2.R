data <- read.csv(file = "data.csv", header = TRUE);

png(file = "plot2.png")

plot(data$DateTime, data$Global_active_power, xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(data$DateTime, data$Global_active_power, lwd = 1)

dev.off()