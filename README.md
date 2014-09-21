---
title: "Getting and Cleaning Data Project README"
author: "Hiep Khuu"
date: "Saturday, September 20, 2014"
output: pdf_document
---

This document describes general summary information for running the analysis R
script for process of creating tidy data from raw untidy data.

The untidy raw data are provided from Human Activity Recognition project. For details of the data, see README.txt of the data set folder "UCI HAR Dataset".
The run_analsys.R script will load up both the test and train data sets provided and do appropriate manipulation to clean it up and make it tidy, complying with tidy data principle for all necessary analysis.

List of files:
--------------

"README.md" : Describe overall files and processes involved in cleaning up raw untidy data into tidy data for analysis. The data come from the Human Activity Detection project.

"Cookbook.md" : Describe more details about the tidy data set after being cleaned up and the necessary information about how the data can be used for analysis.

"run_analysis.R" : the R script file execute on the raw data set to create a new tidy data set for analysis, and also does one analysis of computing the mean of each variable column for each activity state and each experiment subject Id.


The run_analysis.R script:
--------------------------
This script file load the test and train data into data frame of following layout format in column-wise

  | Test data   | derived Activity | Experiment Subject Id |
  | Train data  | derived Activity | Experiment Subject Id |
  
The derived activity data are numbers, whose corresponding string are store in separate data file, activity_lablels.txt. The script does a simple mapping to replace activity state values with their corresponding activity names.

The raw untidy data sets are read into data table NOT as factors, as the script intends to process data cleaning using basic data types like strings and numeric, instead of factors.

Cleaning up to make data tidy also includes making names of variables easily readable. Hence, it will do followigs:
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

Once the data set become tidy and properly formatted in data frame, including easily readable data variable names, analysis of the data becomes a lot easier using R. The run_analysis.R script does one analysis of computing the mean of each variable data for each subject Id and each activity state using the tidy data.