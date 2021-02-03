# Coursera, Getting and Cleaning Data course project

# 1.  Merges the training and the test sets to create one data set.
# 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.  Uses descriptive activity names to name the activities in the data set.
# 4.  Appropriately labels the data set with descriptive variable names.
# 5.  From the data set in step 4, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.

setwd('C:/Users/Hidde/Documents/Coursera/Data Science Foundations using R Specialization/3_Getting_And_Cleaning_Data/project')

if (!file.exists('data')) {
      dir.create('data')
}

# Load packages
library('data.table')

# Download the data files
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
path <- getwd()
f <- file.path(path, './data/project_files.zip')
download.file(fileUrl, f)
unzip(zipfile = './data/project_files.zip')

# Load activity labels and features from the dataset
activityLabels <- fread(file.path(path, 'UCI HAR Dataset/activity_labels.txt'), 
                        col.names = c('classLabels', 'activityName'))

features <- fread(file.path(path, 'UCI HAR Dataset/features.txt'),
                  col.names = c('index', 'featureName'))

# Set the mean and standard deviation for each measurement
featuresWanted <- grep('mean|std)\\(\\)', features[, featureName])
measurements <- features[featuresWanted, featureName]
measurements <- gsub('[()]', '', measurements)

# Load the train dataset
train_data <- fread(file.path(path, 'UCI HAR Dataset/train/X_train.txt'))[, featuresWanted, with = FALSE]
setnames(train_data, colnames(train_data), measurements)
trainActivities <- fread(file.path(path, 'UCI HAR Dataset/train/Y_train.txt'),
                         col.names = c('Activity'))
trainSubjects <- fread(file.path(path, 'UCI HAR Dataset/train/subject_train.txt'),
                       col.names = c('SubjectNumber'))
train_data <- cbind(trainSubjects, trainActivities, train_data)

# Load the test dataset
test_data <- fread(file.path(path, 'UCI HAR Dataset/test/X_test.txt'))[, featuresWanted, with = FALSE]
setnames(test_data, colnames(test_data), measurements)
testActivities <- fread(file.path(path, 'UCI HAR Dataset/test/Y_test.txt'),
                         col.names = c('Activity'))
testSubjects <- fread(file.path(path, 'UCI HAR Dataset/test/subject_test.txt'),
                       col.names = c('SubjectNumber'))
test_data <- cbind(testSubjects, testActivities, test_data)

# Merge datasets
merged_data <- rbind(train_data, test_data)

# Create the tidy dataset
merged_data[['Activity']] <- factor(merged_data[, Activity], levels = activityLabels[['classLabels']],
                                    labels = activityLabels[['activityName']])

merged_data[['SubjectNumber']] <- as.factor(merged_data[, SubjectNumber])

merged_data <- melt(merged_data, id = c('SubjectNumber', 'Activity'))
merged_data <- dcast(merged_data, SubjectNumber + Activity ~ variable, fun.aggregate = mean)

fwrite(merged_data, file = 'tidyDataset.txt', row.names = FALSE)
