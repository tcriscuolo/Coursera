library(ggplot2);
NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

png(file = "plot3.png", height = 600, width = 700)

data <- NEI[NEI$fips == "24510", ];
info <- aggregate(Emissions ~ year + type, data, sum, na.rm = TRUE);

q <- qplot(year, Emissions, data = info,  facets = .~type);
q <- q + geom_line() + ggtitle("Total emission of PM2.5 in Baltimore City from 1999 to 2008");
plot(q);
dev.off();