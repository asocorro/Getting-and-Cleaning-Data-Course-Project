# Getting and Cleaning Data Course Project
## Codebook

The final, tidy data set is created by integrating and manipulating the various source data sets.  Please recall from the Readme file that 
all source data files are available from here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The source data for the actual readings of activities are divided into train and test data sets, provided in six files, three for training data and three for test data.  One file contains the readings, another file the activity for each reading, and the third file the subject that performed each activity.  The files have the same number of rows and relate to each other by their physical position in the file.  Therefore, the n-th line of the readings file refers to the activity indicated in the n-th line of the activity file and was performed by the subject indicated in the n-th line of the subject file.  The files are the following:

* Readings: X_train.txt and X_test.txt
* Activities: y_train.txt and y_test.txt
* Subjects: subject_train.txt and subject_test.txt

The variables in the readings files are described in detail in a source file called features_info.txt.  For easy reference, we list all 561 of them in the file ReadingsVariables.md in this repository.

In the Activities file mentioned above, activities are indicated using numeric identifiers between 1 and 6.  The relationship between the identifiers and the activity names is given by the source file activity_labels.txt.  There is no such file for the thirty subjects in the study as they are referred to only by numbers between 1 and 30.

The algorithm for producing the final, tidy data set as per the project requirements is well-documented in the source code itself in file run_analysis.R.  The structure of the final, tidy data set consists of 180 rows and 68 columns.  There is exactly one row per subject per activity (30 subjects times 6 activities).  Of the 68 columns, 66 are per the project requirement of considering only the variables in the readings files for mean and std data.  The other two columns are added programmaticaly and label the activity and the subject.  This extract shows the first few rows and the first few columns of the final, tidy data set:

| subjectId | activityName | tBodyAcc-mean()-X | tBodyAcc-std()-X | tBodyAcc-mean()-Y | tBodyAcc-std()-Y 
| --- | --- | --- | --- | --- | ---  
| 1             | LAYING       |  0.2215982     | -0.92805647   |   -0.040513953   |  -0.836827406
| 1            | SITTING       |  0.2612376     |  -0.97722901  |   -0.001308288   | -0.922618642
| 1           | STANDING       |  0.2789176     | -0.99575990   |  -0.016137590    | -0.973190056
| 1           | WALKING        | 0.2773308      | -0.28374026   |  -0.017383819    |  0.114461337
| 1 | WALKING_DOWNSTAIRS       |  0.2891883     |  0.03003534   |  -0.009918505    | -0.031935943
| 1 | WALKING_UPSTAIRS         | 0.2554617      |  -0.35470803  |   -0.023953149   |          -0.002320265
 
