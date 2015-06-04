library(ggplot2);
NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

png(file = "plot4.png");

coalPos <- grep("coal", SCC$Short.Name, ignore.case = TRUE);
coalIds <- SCC$SCC[coalPos];

data <- NEI[NEI$SCC %in% coalIds, ];

info <- aggregate(Emissions ~ year, data = data, sum, na.rm = TRUE);
q <- qplot(year, Emissions, data = info)
q <- q + geom_line()+ ggtitle("Total emission of PM2.5 from coal sources across United States");
plot(q)
dev.off();