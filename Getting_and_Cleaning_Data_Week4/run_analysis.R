
###
# The following script performs the following:

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Note: First set the working directory

####



outDir<-"zip_Folder"
fileurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(outDir)){
  download.file(fileurl, "smartphoneData.zip", method = "libcurl")
}

zipF<-"smartphoneData.zip"
unzip(zipF, exdir = outDir)

# 1. Merge the train and test datasets
# Load the training set
x_train_data<-read.table("zip_Folder/UCI HAR Dataset/train/X_train.txt")
y_train_data<-read.table("zip_Folder/UCI HAR Dataset/train/y_train.txt")
subject_train_data<-read.table("zip_Folder/UCI HAR Dataset/train/subject_train.txt")

# Load the test set
x_test_data<-read.table("zip_Folder/UCI HAR Dataset/test/X_test.txt")
y_test_data<-read.table("zip_Folder/UCI HAR Dataset/test/y_test.txt")
subject_test_data<-read.table("zip_Folder/UCI HAR Dataset/test/subject_test.txt")

# Read the feature names
feature_names<-read.table("zip_Folder/UCI HAR Dataset/features.txt")
features<-feature_names[,2]
features<-as.character(features)

#str(feature_names[,2])
# Read the activity labels
activity_labels<-read.table("zip_Folder/UCI HAR Dataset/activity_labels.txt")

# Merge the datasets
train_data<-cbind(x_train_data, subject_train_data, y_train_data)
test_data<-cbind(x_test_data, subject_test_data, y_test_data)

data<-rbind(train_data, test_data)

# vector of column names
feature_names<-c(features, "subjectId", "activityId")

# set names of colums
colnames(data)<-feature_names

# 2. Exctract only measurements on the mean and standard deviation for each measurement.
library(dplyr)
data_subset_mean<-data[,grepl("mean", colnames(data))]
data_subset_std<-data[,grepl("std", colnames(data))]
data_subset<-cbind(data["activityId"], data["subjectId"], data_subset_mean, data_subset_std)
str(data_subset)


# 3. Uses descriptive activity names to name the activities in the data set

data_subset$activityId<- factor(data_subset$activityId, labels = as.character(activity_labels[,2]))


# 4. Appropriately label the dataset with descriptive variable names
# This is dones with the above. It would be possible to replace the variable names such that the 't' is replaced with 'time',
# or that 'f' is replaced with 'frequency', 'Acc' with 'Accelerometer' and so on, using the gsub function. However,
# I believe this would make the variable names too lenghty.

# 5 Create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data<-data_subset %>% group_by(activityId, subjectId) %>% summarise_all(funs(mean))
str(tidy_data)

# Write to a text file
write.table(tidy_data, "tidydata.txt", row.names = FALSE, quote = FALSE)
