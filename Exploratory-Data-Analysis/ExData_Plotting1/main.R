#Pre process the data

# It is assumed that the household power consumption file
# is ins in the same working directory
# The raw data set can be found at this link
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
data <- read.table(file = "household_power_consumption.txt", sep = ";",
                   na.strings = c("NA", "?"), header = TRUE);

# Subset the dataset 
data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# Create a data and time variable
date <- paste(data$Date, data$Time);
data$DateTime <- strptime(date, "%d/%m/%Y %H:%M:%S")
dim(data);

write.csv(data, file = "data.csv", row.names = F)
