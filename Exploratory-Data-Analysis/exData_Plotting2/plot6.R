library(ggplot2);
NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

png(file = "plot6.png");
# Get all motor vehicle IDS
motorVehiclePos <- grep("motor", SCC$Short.Name, ignore.case = TRUE);
motorVehicleIds <- SCC$SCC[motorVehiclePos];

### get Baltimore and Los Angeles information
data <- NEI[NEI$fips %in% c("24510", "06037"), ];
data <- data[data$SCC %in% motorVehicleIds, ];

data$fips <- ifelse(data$fips == "24510","Baltimore", "Los Angeles")

info <- aggregate(Emissions ~ year + fips, data = data, sum, na.rm = TRUE);

q <- qplot(year, Emissions, data = info, facets = . ~ fips);
q <- q + geom_line()+ ggtitle("Total emission of PM2.5 from motor vehicles in Baltimore and Los Angeles");
plot(q)
dev.off();