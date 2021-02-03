# Coursera_Getting-and-Cleaning-Data-Course-Project

## Goal of the project:
1. Prepare a tidy data set 
2. Create a link to a Github repository with the script for performing the analysis 
3. Write a code book that describes the variables, the data, and any transformations or work that is performed to clean up the data called CodeBook.md. 
4. Include a README.md in the repo with the scripts. This repo explains how all of the scripts work and how they are connected.

## Initial data:
the data originates from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and the dataset can be found here [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

Files used from the dataset:
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': including the measurements of the features for the training set.
- 'train/y_train.txt': activity (from 1 to 6) for each measurement (training labels) for the training set.
- 'train/subject_train.txt': subject for each measurement from the train set.
- 'test/X_test.txt': including the measurements of the features for the test set.
- 'test/y_test.txt': activity (from 1 to 6) for each measurement (test labels) for the test set.
- 'test/subject_test.txt': subject for each measurement from the test set.

## The script:
1. Download the activitities and features from the activity_labels.txt and features.txt, respectively.
2. Extract the mean and standard deviation for each measurement from the features dataset
3. Load the training and test data
  a. Load the train/test_data (X_train/test)
  b. Load the activities data for train/test (Y_train/test)
  c. Load the subjects data for train/test (subject_train/test)
  d. Combine the subject and activities datasets with the train/test_data based on the columns
4. Merge the train and test datasets based on the rows
5. Create the tiny dataset
  a. Give descriptive values for activity labels
  b. Create a melted dataset using activity label and subject as IDs
  c. Define the mean values for all the variables, grouped by the activity and subject using dcast()
  d. Write the tiny dataset in a txt file
