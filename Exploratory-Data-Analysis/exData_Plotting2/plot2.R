NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

png(file = "plot2.png")

data <- NEI[NEI$fips == "24510", ];
info <- tapply(data$Emissions, data$year, sum, na.rm = TRUE);

barplot(info, col = "blue", xlab = "Year", ylab = "Emission of PM2.5",
        main = "Total emission of PM2.5 in Baltimore City from 1999 to 2008");

dev.off();