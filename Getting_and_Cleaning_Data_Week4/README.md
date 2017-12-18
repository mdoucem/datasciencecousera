## Getting and Cleaning Data Week 4 Course Project

The R script included in the run_analysis.R performs the the following.

First it downloads and unzips the Human Activity Recognition from Smartphones dataset. A description of the data is provided here ->
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script then performs a series of operations to obtain a tidy data set, see the tidydata.txt file for the output. The script:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Assigns descriptive activity names and variable names to the data set
- From the data set created in the previous step, it creates another, independent tidy data set with the average of 
each variable for each activity and each subject.
