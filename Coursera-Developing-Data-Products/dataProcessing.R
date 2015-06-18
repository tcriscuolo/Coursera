library(data.table)

# Pre process the data from EPA data set 
unzip("data/daily_44201_2013.csv.zip", exdir = "data/")
data <- read.csv("data/daily_44201_2013.csv", header = TRUE, sep = ",")
da <- as.data.table(data);
data <- as.data.frame(da[ , list(OZONE = round(mean(Arithmetic.Mean, na.rm = T), 2), 
                                 AQI = round(mean(AQI, na.rm = T), 0)),
                         by =  list(State.Code, County.Code, Site.Num, Longitude, Latitude, Address)]);
stateList <- unique(loc$State.Code)
save(data, file = "data/data.Rda")
save(stateList, file = "data/stateList.Rda")
