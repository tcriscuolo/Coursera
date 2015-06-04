library(ggplot2);
NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

png(file = "plot5.png");
# Get all motor vehicle IDS

motorVehiclePos <- grep("motor", SCC$Short.Name, ignore.case = TRUE);
motorVehicleIds <- SCC$SCC[motorVehiclePos];

# Subset Baltimore
data <- NEI[NEI$fips == "24510", ];
data <- data[data$SCC %in% motorVehicleIds, ];

info <- aggregate(Emissions ~ year, data = data, sum, na.rm = TRUE);
q <- qplot(year, Emissions, data = info)
q <- q + geom_line()+ ggtitle("Total emission of PM2.5 from motor vehicles in Baltimore");
plot(q)
dev.off();