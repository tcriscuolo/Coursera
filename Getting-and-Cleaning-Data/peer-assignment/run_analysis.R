library(data.table);
library(dplyr);

# Part 1
# Merge training and test set
testData <- read.table(file = "UCI HAR Dataset/test/X_test.txt");
trainData <- read.table(file = "UCI HAR Dataset/train/X_train.txt");
testSubject <- read.table(file = "UCI HAR Dataset/test/subject_test.txt");
trainSubject <- read.table(file = "UCI HAR Dataset/train/subject_train.txt");
testLabel <- read.table(file = "UCI HAR Dataset/test/y_test.txt");
trainLabel <- read.table(file = "UCI HAR Dataset/train/y_train.txt");

mergeData <- rbind(testData, trainData);
mergeSubject <- rbind(testSubject, trainSubject);
mergeLabel <- rbind(testLabel, trainLabel);

# Remove unnecessary variables 
rm("testData"); rm("trainData"); rm("testSubject"); rm("trainSubject"); rm("testLabel"); rm("trainLabel");

# Part 2
# Extract only measurement on the mean and strandard deviation for each measurement 
measuresNames <- as.character(read.table(file = "UCI HAR Dataset/features.txt")[ , 2]);
measuresToConsider <- grep("-mean\\(\\)|-std\\(\\)", measuresNames, ignore.case = TRUE);
mergeData <- mergeData[ ,measuresToConsider];

# Part 3
# Use descriptive activity names to name the activities in the data set
activitiesNames <- read.table(file = "UCI HAR Dataset/activity_labels.txt")[ ,2];
activitiesNames <- tolower(activitiesNames);
activitiesNames <- gsub("_", " ", activitiesNames);

measuresNames <- measuresNames[measuresToConsider];
measuresNames <- gsub("\\(\\)", "", measuresNames);
measuresNames <- gsub("-", "", measuresNames);

# Part 3
#Appropriately labels the data set with descriptive variable names
names(mergeData) <- measuresNames;
names(mergeLabel) <- c("activities");
names(mergeSubject) <- c("subject");

# Part 4
# From the data set in step 4, 
# creates a second, independent tidy data set with
# the average of each variable for each activity and each subject
finalData <- tbl_df(cbind( mergeSubject, mergeLabel, mergeData));
names(finalData) <- c(names(mergeSubject),  names(mergeLabel), names(mergeData));
groupData <- group_by(finalData, subject, activities);
mySummary <- summarise_each(groupData, funs(mean));

nactivities <- sort(unique(finalData$activities));
nactivities <- factor(nactivities, labels = activitiesNames);
finalData$activities <- nactivities[finalData$activities];
mySummary$activities <- nactivities[mySummary$activities];

write.table(finalData, file = "merged_data.txt");
write.table(mySummary, file = "mean_data.txt");

                             
                             
                             