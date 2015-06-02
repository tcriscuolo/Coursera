data <- read.csv(file = "data.csv", header = TRUE);


png(file = "plot1.png")

hist(data$Global_active_power, col = "red", main = "Global Active Power")

dev.off()