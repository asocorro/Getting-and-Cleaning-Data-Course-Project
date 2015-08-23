# Getting and Cleaning Data Course Project

The purpose of this project is to collect, work with, and clean a data set.  The goal is to prepare tidy data that can be used for later analysis.

The data set is from a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.  For more information, please see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The code implements the five project requirements:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The entire source code for the solution is in a file called run_analysis.R.  The code is well-documented and should be easy to follow.  However,
please note:

* The code depends on the dplyr and reshape packages, and will try to load the corresponding libraries in the beginning.
* The code assumes that the raw data set files are in a folder called "UCI HAR Dataset" and that this folder is under the current working directory.  If you intend to run the code, uncomment the "setwd" command to establish the proper working directory.

The final, tidy data set is output to a file called FinalData.txt.
