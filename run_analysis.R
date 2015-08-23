# -------------------------------------------------------#
## Getting and Cleaning Data -- Course Project (Week 3) ##
# -------------------------------------------------------#

# Project Requirements: 
#
# You should create one R script called run_analysis.R that does the following:
#
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names. 
#   5. From the data set in step 4, creates a second, independent tidy data set with the average 
#       of each variable for each activity and each subject.

# this scripts assumes that the raw data set files are in a folder called "UCI HAR Dataset"
# and that this folder is under the currheadent working directory.  Thefore, make sure you 
# establish the correct working directory before running this script.
# setwd("<Folder Path>#)

# setwd("O:/Personal/Coursera/3- Getting and Cleaning Data/Course Project")

# before getting into the project requirements, we load the necessary libraries and data sets

# load the dplyr library
library(dplyr)
# load the reshape library
library(reshape)

# read the test and the train data and then convert them to dplyr tables
test_data_staging <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
train_data_staging <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
test_data <- as.tbl(test_data_staging)
train_data <- as.tbl(train_data_staging)

# read the column names and assign them to both tables
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
names(test_data) <- features$V2
names(train_data) <- features$V2

#---------------
## REQUIREMENT 1: Merges the training and the test sets to create one data set.
#---------------
all_data <- rbind(test_data, train_data)


#---------------
## REQUIREMENT 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#---------------

# get all the columns with "mean()" in their names
mean_cols <- grep("mean[(][)]", features$V2, value = FALSE)

# get all the columns with "std()" in their names
std_cols <- grep("std[(][)]", features$V2, value = FALSE)

# bind them together
mean_and_std_cols <- rbind(mean_cols, std_cols)

# keep all rows but only the mean() and std() columns
# after this, we are left with 66 columns
all_data <- all_data[mean_and_std_cols]


#---------------
## REQUIREMENT 3: Uses descriptive activity names to name the activities in the data set
#---------------
# the activities for each record in the data sets are in the files train/y_train.txt and test/y_test.txt.
# each of those files is implicitly related by row number (i.e., physical position in the file) to the 
# corresponing main data sets; this is why, for example, X_test.txt (the measurements file) has the same 
# number of rows as y_test.txt (the acivity labels).

# therefore, we will combine the activity files row-wise, in the same order as we combined the measurement
# files, and then we will append them column-wise to the all_data data set.  we will end up with each 
# row/observation having an extra column/variable with the activity name.

# first, read in the activity IDs and their labels
activity_labels_staging <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels <- as.tbl(activity_labels_staging)

# second, read in the activity files for the train and test data and then row-bind them together
test_activities_staging <- read.table("./UCI HAR Dataset/test/y_test.txt")
train_activities_staging <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_activities <- as.tbl(test_activities_staging) 
train_activities <- as.tbl(train_activities_staging)
all_activities <- rbind(test_activities, train_activities)

# next, replace the activity IDs with activity labels and rename
all_activities <- inner_join(all_activities, activity_labels, by = "V1") %>% rename(c("V2"="activityName")) %>% select(activityName)

# finally, add the activity column to the main data set
all_data <- cbind(all_activities, all_data)


#---------------
## REQUIREMENT 4: Appropriately labels the data set with descriptive variable names. 
#---------------
# This was already done above:

#     # read the column names and assign them to both tables
#     features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
#     names(test_data) <- features$V2
#     names(train_data) <- features$V2

# but let's also add in the subject labels, in the same way we added the activity labels for Requirement 3
test_subjects_staging <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_subjects_staging <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subjects <- as.tbl(test_subjects_staging) 
train_subjects <- as.tbl(train_subjects_staging) 
all_subjects <- rbind(test_subjects, train_subjects) %>% rename(c("V1"= "subjectId"))

all_data <- cbind(all_subjects, all_data)


#---------------
## REQUIREMENT 5: From the data set in step 4, creates a second, independent tidy data set with the average 
#                 of each variable for each activity and each subject.
#---------------

# reshape the data, grouping by subjectId and activityName
m <-melt(all_data, id=c("subjectId", "activityName"))

# m looks something like this:
# subjectId activityName          variable     value
# 1         2     STANDING tBodyAcc-mean()-X 0.2571778
# 2         2     STANDING tBodyAcc-mean()-X 0.2860267
# 3         2     STANDING tBodyAcc-mean()-X 0.2754848
# 4         2     STANDING tBodyAcc-mean()-X 0.2702982
# 5         2     STANDING tBodyAcc-mean()-X 0.2748330
# 6         2     STANDING tBodyAcc-mean()-X 0.2792199


# now we put the data back into it's original shape, but in the process calculating 
# the mean value for each combination of subjectId and activityName and for each variable
final_data <- cast(m, subjectId + activityName ~ variable, mean)

# the result is a table with 180 rows (30 subjects x 6 activities) and 68 columns
# these are the first six columns of head(final_data)

# subjectId   activityName         tBodyAcc-mean()-X  tBodyAcc-std()-X  tBodyAcc-mean()-Y  tBodyAcc-std()-Y 
# 1           LAYING               0.2215982          -0.92805647       -0.040513953       -0.836827406
# 1           SITTING              0.2612376          -0.97722901       -0.001308288       -0.922618642
# 1           STANDING             0.2789176          -0.99575990       -0.016137590       -0.973190056
# 1           WALKING              0.2773308          -0.28374026       -0.017383819        0.114461337
# 1           WALKING_DOWNSTAIRS   0.2891883           0.03003534       -0.009918505       -0.031935943
# 1           WALKING_UPSTAIRS     0.2554617          -0.35470803       -0.023953149       -0.002320265

# put the final tidy data set into a file
write.table(final_data, file = "FinalData.txt", row.name = FALSE)
