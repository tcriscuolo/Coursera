NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png(file = "plot1.png")

info <- tapply(NEI$Emissions, NEI$year, sum, na.rm = TRUE)

barplot(info, xlab = "Year", ylab = expression("Total emission of PM2.5"), col= "blue")
# the sum decreased
dev.off();