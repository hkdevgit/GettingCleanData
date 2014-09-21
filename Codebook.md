---
title: "Getting and Cleaning Data Project Coobook"
author: "Hiep Khuu"
date: "Saturday, September 20, 2014"
output: pdf_document
---

This Cookbook provides details of the tiday data, which were cleaned up from the original untidy data. The original untidy data are provided from Human Activity Recognition using Smartphones Dataset, by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

The original untiday data have 10299 observations of both test and train data combined, and they are of 561 variables of measurements of device's sensors, i.e. Accelerometer, Gyroscope, etc... plus one variable of the derived activity state based on data of 561 variables and one variable telling experiment subject ID.
The data are untidy since each variable has unclear naming.

Therefore, the effort here is to clean up the data, and do an analysis of the data to compute the average of each variable for same subject Id and activity state. The data used for the computation of average are only the mean and standard deviation variables.

The mean and standard deviation variables include both all sensors' data and the angle data between sensors' and gravity mean. That gives us 10299 observations of 79 variables. 
The variables are cleaned up using the following rules:
  - Remove unnecessary characters "()", "-", ","
  - Remove duplicate "Body" word in variable names
  - Replace following abbreviations with meaningful and reable names
      Acc   -> Accelerometer
      Gyro  -> Gyroscope
      Mag   -> Magnitude
      mean  -> Mean
      std   -> StandardDeviation
      tBody -> timeBody
      fBody -> frequencyBody
      tGravity -> timeGravity


And here are the cleaned up variable names:

timeBodyAccelerometerMeanX 
timeBodyAccelerometerMeanY 
timeBodyAccelerometerMeanZ
timeGravityAccelerometerMeanX 
timeGravityAccelerometerMeanY
timeGravityAccelerometerMeanZ 
timeBodyAccelerometerJerkMeanX
timeBodyAccelerometerJerkMeanY 
timeBodyAccelerometerJerkMeanZ 
timeBodyGyroscopeMeanX
timeBodyGyroscopeMeanY 
timeBodyGyroscopeMeanZ 
timeBodyGyroscopeJerkMeanX
timeBodyGyroscopeJerkMeanY 
timeBodyGyroscopeJerkMeanZ
timeBodyAccelerometerMagnitudeMean 
timeGravityAccelerometerMagnitudeMean
timeBodyAccelerometerJerkMagnitudeMean 
timeBodyGyroscopeMagnitudeMean
timeBodyGyroscopeJerkMagnitudeMean 
frequencyBodyAccelerometerMeanX
frequencyBodyAccelerometerMeanY 
frequencyBodyAccelerometerMeanZ
frequencyBodyAccelerometerMeanFreqX 
frequencyBodyAccelerometerMeanFreqY
frequencyBodyAccelerometerMeanFreqZ 
frequencyBodyAccelerometerJerkMeanX
frequencyBodyAccelerometerJerkMeanY 
frequencyBodyAccelerometerJerkMeanZ
frequencyBodyAccelerometerJerkMeanFreqX 
frequencyBodyAccelerometerJerkMeanFreqY
frequencyBodyAccelerometerJerkMeanFreqZ 
frequencyBodyGyroscopeMeanX
frequencyBodyGyroscopeMeanY 
frequencyBodyGyroscopeMeanZ
frequencyBodyGyroscopeMeanFreqX 
frequencyBodyGyroscopeMeanFreqY
frequencyBodyGyroscopeMeanFreqZ 
frequencyBodyAccelerometerMagnitudeMean
frequencyBodyAccelerometerMagnitudeMeanFreq
frequencyBodyAccelerometerJerkMagnitudeMean
frequencyBodyAccelerometerJerkMagnitudeMeanFreq 
frequencyBodyGyroscopeMagnitudeMean
frequencyBodyGyroscopeMagnitudeMeanFreq 
frequencyBodyGyroscopeJerkMagnitudeMean
frequencyBodyGyroscopeJerkMagnitudeMeanFreq 
timeBodyAccelerometerStandardDeviationX
timeBodyAccelerometerStandardDeviationY 
timeBodyAccelerometerStandardDeviationZ
timeGravityAccelerometerStandardDeviationX
timeGravityAccelerometerStandardDeviationY
timeGravityAccelerometerStandardDeviationZ
timeBodyAccelerometerJerkStandardDeviationX
timeBodyAccelerometerJerkStandardDeviationY
timeBodyAccelerometerJerkStandardDeviationZ 
timeBodyGyroscopeStandardDeviationX
timeBodyGyroscopeStandardDeviationY 
timeBodyGyroscopeStandardDeviationZ
timeBodyGyroscopeJerkStandardDeviationX 
timeBodyGyroscopeJerkStandardDeviationY
timeBodyGyroscopeJerkStandardDeviationZ
timeBodyAccelerometerMagnitudeStandardDeviation
timeGravityAccelerometerMagnitudeStandardDeviation
timeBodyAccelerometerJerkMagnitudeStandardDeviation
timeBodyGyroscopeMagnitudeStandardDeviation
timeBodyGyroscopeJerkMagnitudeStandardDeviation
frequencyBodyAccelerometerStandardDeviationX
frequencyBodyAccelerometerStandardDeviationY
frequencyBodyAccelerometerStandardDeviationZ
frequencyBodyAccelerometerJerkStandardDeviationX
frequencyBodyAccelerometerJerkStandardDeviationY
frequencyBodyAccelerometerJerkStandardDeviationZ
frequencyBodyGyroscopeStandardDeviationX 
frequencyBodyGyroscopeStandardDeviationY
frequencyBodyGyroscopeStandardDeviationZ
frequencyBodyAccelerometerMagnitudeStandardDeviation
frequencyBodyAccelerometerJerkMagnitudeStandardDeviation
frequencyBodyGyroscopeMagnitudeStandardDeviation
frequencyBodyGyroscopeJerkMagnitudeStandardDeviation 


The file "ComputedMeanPerSubjectIdAndActivity.txt" should be read in as table, i.e using read.table() function. The table has 180 rows of observation data of 79 variables of data that help derive at the activity state. Each row is an observation of all 79 variable data.

The cleaning up of the data are as followings, and done in the "run_analysis.R" script:
1) Merges the training and the test sets to create one data set.

2) Extracts only the measurements on the mean and standard deviation for each measurement. It includes all mean and standard deviation of sensors' data and the angle between the sensors' data and gravity. That gives 79 variables.

3) Uses descriptive activity names to name the activities in the data set

4) Appropriately labels the data set with descriptive variable names, including the activity state and experiement subject Id identifying observation data of all those 79 variables.

5) Then, from the tidy data set, the "run_analysis.R" script independent tidy data set with the average of each variable for each activity and each subject, and stored in "ComputedMeanPerSubjectIdAndActivity.txt"
