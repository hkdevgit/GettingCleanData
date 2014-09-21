# This function analyzes the Train and Test dataset, and then compute
# the average of all the mean's and standard deviation's related variables for
# each subject Id and activity, using the cleaned up datasets.

run_analysis <- function() {
  
  # Load necessary utility libraries for usage throughout the
  # analysis script
  library(plyr)
  library(dplyr)
  library(reshape2)
  library(tidyr)
  
  features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, stringsAsFactors=FALSE)
  labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, stringsAsFactors=FALSE)
  testX <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, stringsAsFactors=FALSE)
  testY <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, stringsAsFactors=FALSE)
  trainX <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, stringsAsFactors=FALSE)
  trainY <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, stringsAsFactors=FALSE)
  testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, stringsAsFactors=FALSE)
  trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, stringsAsFactors=FALSE)
  
  # Step 1:
  # Merged Test and Train data X and Y into one data frame as column-wise, 
  # as separate features of same number of observations
  TestData <- cbind(testX, testY, testSubjects)
  TrainData <- cbind(trainX, trainY, trainSubjects)
  Data <- rbind(TestData, TrainData)
  
  # Also, add the name of the Activity and Subject ID to features data frame
  # for convenience of assigning the colum variable names later
  # The Data already contained the activity and subject ID columns, so their
  # indexes are already accounted for
  features <- features %>% 
              rbind(c(length(Data)-1, "ActivityState")) %>%
              rbind(c(length(Data), "ExperimentSubjectId"))
  
  # Step 2:
  # Extract the mean and standard deviation for each measurement
  
  # First, acquire the indices of all measurements corresponding to mean and std feature
  # The indices maps back to the original variable name of the measurement.
  # For instance, 
  #    [1] <--> "tBodyAcc-mean()-X"
  #    [4] <--> "tBodyAcc-std()-X"
  meanFeatIndexes <- as.numeric(features[grep("mean", features[,2]),1])
  stdFeatIndexes <- as.numeric(features[grep("std", features[,2]),1])
  
  
  # Step 3:
  # Create activity names for the activity values of the data set

  # First, map the activity value to the corresponding activity name strings that we read in 
  # from activity_labels.txt above.
  # The 'labels' is read in NOT as factors, so we can do the mapping directly where
  # first column is index value and the 2nd column is the corresponding string names
  activityCol <- mapvalues(Data[,length(Data)-1], labels$V1, labels$V2)
  
  # Then, select subset of data corresponding to those combined features
  # Also bind the activity and then subject ID columns, using dplyr operator "%>%"
  # We will need the subject ID later on
  NonameData <- Data %>% 
                select(meanFeatIndexes, stdFeatIndexes) %>%
                cbind(activityCol) %>%
                cbind(Data[,length(Data)])
    
  # Step 4:
  # Label each column of the data with appropriate descriptive variable names
  
  # Tidy up the feature names
  # Removing followings "()-"
  # Replace double "BodyBody" into single "Body"
  # Replace abbreviations with full variable names
  # Maintain the first character as lower case for variable naming convention
  features$V2 <- gsub("\\(\\)", "", features$V2)
  features$V2 <- gsub("-", "", features$V2)
  features$V2 <- gsub(",", "", features$V2)
  features$V2 <- gsub("BodyBody", "Body", features$V2)
  features$V2 <- gsub("Acc", "Accelerometer", features$V2)
  features$V2 <- gsub("Gyro", "Gyroscope", features$V2)
  features$V2 <- gsub("Mag", "Magnitude", features$V2)
  features$V2 <- gsub("mean", "Mean", features$V2)
  features$V2 <- gsub("std", "StandardDeviation", features$V2)
  features$V2 <- gsub("tBody", "timeBody", features$V2)
  features$V2 <- gsub("fBody", "frequencyBody", features$V2)
  features$V2 <- gsub("tGravity", "timeGravity", features$V2)
  
  # Extract the column names corresponding to the mean and standard deviation
  # measurements of the data set
  # Also, append the activity name to the features to match the dimension of
  # data set and their corresponding variable names (as columns) of those data
  ColNames <- data.frame()
  ColNames <- rbind(ColNames, features[meanFeatIndexes,])
  ColNames <- rbind(ColNames, features[stdFeatIndexes,])
  ColNames <- rbind(ColNames, features[length(features$V1)-1,])
  ColNames <- rbind(ColNames, features[length(features$V1),])

  # Create a nicely formatted data set with proper variable names
  NamedData <- data.frame(NonameData)
  names(NamedData) <- ColNames$V2
  
  # Step 5:
  # Read in the subject of test and train data and create a new independent
  # tidy data set with the average of each variable column for each activity type and
  # and each subject ID
  subjectIdCat <- unique(NamedData$ExperimentSubjectId)
  activityCat <- unique(NamedData$ActivityState)
  
  ComputedMeanData <- data.frame()
  
  # For each ExperimentSubjectId, compute the mean of each ActivityState category
  # First, we filter out all rows of corresponding ExperimentSubjectId category we're
  # tryingt to compute the mean for.
  # Then, within that filter data set, we use ddply to compute the mean per each
  # ActivityState category column-wise
  # The computed mean of all variable columns are appended into the ComputedMeanData data frame
  for (subjectId in 1:length(subjectIdCat)) {
    for (activityId in 1:length(activityCat)) {
      tmpData <- NamedData %>%
                 filter(ExperimentSubjectId == subjectIdCat[subjectId]) %>%
                 select(-ActivityState, -ExperimentSubjectId) %>%
                 ddply(.(subjectIdCat[subjectId],activityCat[activityId]), numcolwise(mean))
      
      ComputedMeanData <- rbind(ComputedMeanData, tmpData)
    }
  }

  # Update the name of the experiment subject Id category and activity state category
  names(ComputedMeanData)[1] <- "ExperimentSubjectId"
  names(ComputedMeanData)[2] <- "ActivityState"
  
  # Write data to local file
  write.table(ComputedMeanData, file="./ComputedMeanPerSubjectIdAndActivity.txt", row.names=FALSE)
  
}
