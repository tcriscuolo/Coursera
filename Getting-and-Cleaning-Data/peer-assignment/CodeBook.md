///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  This file describes how run_analysis.R transform the data
  * The raw data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  * The run_analysis.R has no parameters
  
  The data is transformed in the following sequence
   -> The data from test and train set are merged
        The data merged are X_test with X_train, subject_train with subject_test and y_test with y_train
        Variables from X_test and X_train are normalized between [-1,1]
        Variables in subject_train and subject_test are natural numbers
        Variables in y_test and y_train are a natural number that represents what activities was perfomed by a subject
   -> It is extracted only measurement about the mean and standard deviation
        In this step it was used regular expression to extract the desired observations
   -> Set descriptive names for variables in the data set
        It was used regular expression to format the measurements in a descriptive way
        All variables are in lower case
        Removed all "()" from variables names
        Transformed "-" to ""
    -> It was created a final data which contains all the data from test and train and a summary which contains the
       mean of all variables grouped by subject and activities
          the final datais the result of merging the subject, y_test and X data respectively 
          the summary data contains the mean of all the variables grouped by subject and activities.
          Finally the final data and summary data are printed in a .txt file with the names of 
          "merged_data.txt" and "merged_data.txt" respectively
          
Tulio Criscuolo
tcriscuolo@gmail.com
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  

  
  
  