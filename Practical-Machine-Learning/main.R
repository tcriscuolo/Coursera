library(caret);
library(randomForest);
library(doMC);
set.seed(125);
###### Data loading
# Download training and unlabeled test data
download.file(url =  "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", destfile = "pml-training.csv", method = "curl")
download.file(url = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv" , destfile = "pml-testing.csv" , method = "curl")

# Data reading
missing_values_flag = c("NA","#DIV/0!", "");
training <- read.csv(file = "pml-training.csv", na.strings = missing_values_flag);

######### Pre processing
# Data preprocessing
dim(training);
colnames(training);

# Removes the row label and user name 
# and the timestamp veriable from the data
# because they are not useful for prediction
training = training[ , -c(1, 2, 3, 4, 5, 6)];

# remove near zero variance predictors
nzvar <- nearZeroVar(training);
training = training[ , -nzvar];

# Check if a given column has more than a threshold (70%) of its values as NA
thresholdNA <- 0.7;
checkNA <- function(col) {
  (sum(is.na(col)) >= (thresholdNA * length(col)))
}

# get variables to remove based on training set
lotNas <- sapply(training, checkNA);

# remove variables from training set
training <- training[ , !lotNas];

# Number of columns
dim(training);

# Now the training set has no na value
any(is.na(training)); 

###### Training data split based on the outcome
# 60% for training
# 30 for testing
trainIndex <- createDataPartition(training$classe, p = .6,
                                  list = FALSE,
                                  times = 1);

inTrain <- training[trainIndex, ];
inTest <- training[-trainIndex, ];

########## Machine learning algorithms

##### Random Forest
registerDoMC(4); # Explicitly register four core
rfModel <- train(classe ~., data = inTrain, method = "parRF");
rfModel;

# Predict using random forest
predRF <- predict(rfModel, inTest);
confusionMatrix(inTest$classe, predRF);



####### Predict hidden data
## Load the data
testing <- read.csv(file = "pml-testing.csv", na.strings = missing_values_flag);
dim(testing);

predHidden <- predict(rfModel, testing);


# Save solutions 
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}


pml_write_files(predHidden);
## It got 19 out of 20 hidden samples right, Well done = )
# End
closeAllConnections();


