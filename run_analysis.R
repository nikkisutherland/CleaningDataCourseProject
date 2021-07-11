####
#
# run_analysis.R
#
# Copyright (C) 2021 Nikki Sutherland
#
####
# 
# This script takes data sets from a study that collected data from the 
# Samsung Galaxy S smartphone's accelerometers:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# A full description is available at the site where the data was obtained:
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
# Using these data sets, the script does the following.
#     1. Merges the training and the test sets to create one data set (called "master_data")
#     2. Extracts only the measurements on the mean and standard deviation for
#        each measurement (does not include meanFreq)
#     3. Uses descriptive activity names to name the activities in the data set
#     4. Appropriately labels the data set with descriptive variable names.
#     5. From "master_data", creates a second, independent tidy data set with the
#        average of each variable for each activity and each subject. (called "means_data")
#
# 
####

library(dplyr)

## Setup data directory
if (!file.exists("./data")) { dir.create("./data") }

## Download the data
zipfile <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zipfile)
dateDownloaded <- date()

## Unzip the file
unzip(zipfile, overwrite = TRUE, list = FALSE, junkpaths = TRUE, exdir = "./data", unzip = "internal", setTimes = FALSE)

## Read in features and activity labels. The feature labels will become the col.names
## in x_test and x_train. The activity labels will be swapped in for the activity IDs
## in y_test and y_train.

feature_labels <- read.table("./data/features.txt",
                             stringsAsFactors=FALSE,
                             col.names = c("FeatureID", "Feature"))     # [561 x 2]

activity_labels <- read.table("./data/activity_labels.txt",
                              col.names = c("ActivityID", "ActivityName"))  # [6 x 2]

# Tidy the activity labels, first make them lowercase and then change _ to a space.
activity_labels$ActivityName <- sapply(activity_labels$ActivityName, tolower)
activity_labels$ActivityName <- sapply(activity_labels$ActivityName, gsub, pattern = "_", replacement = " ")

## Each row identifies the subject who performed the activity for each window sample.
## Its range is from 1 to 30.
subject_test <- read.table("./data/subject_test.txt", col.names = c("SubjectID"))   # [2947 x 1]
subject_train <- read.table("./data/subject_train.txt", col.names = c("SubjectID")) # [7352 x 1]

## The x files contains the readings for the features and the y files contains the
## IDs for the activities that were performed.

y_test <- read.table("./data/y_test.txt",                  # Test activities as IDs [2947 x 1]
                     col.names = c("Activity"))            

X_test <- read.table("./data/X_test.txt",                  # Test data [2947 x 561]
                     # stringsAsFactors=FALSE,
                     col.names = feature_labels$Feature,
                     check.names = FALSE)                  # Keep ()" in the names to make it easier
                                                           # for matching mean() and not meanFreq()

y_train <- read.table("./data/y_train.txt",                # Training activities as IDs [7352 x 1]
                      col.names = c("Activity"))           

X_train <- read.table("./data/X_train.txt",                # Training data [7352 x 561]
                      # stringsAsFactors=FALSE,
                      col.names = feature_labels$Feature,
                      check.names = FALSE)                 # Keep ()" in the names to make it easier
                                                           # for matching mean() and not meanFreq()


## Merge Training and Test data sets

## This will be the huge table we build, piece by piece and it will be [10,299 x 68].
## First we will row bind the subjects into 1 table [10,299 x 1], then the activity
## IDs into a 2nd table [10,299 x 1] and then the test and training data into a
## 3rd table [10,299 x 66].
##
## |_____SubjectID_____|__ActivityID__|___Features___| 
## | subject_test.txt  |  y_test.txt  |  X_test.txt  |
## | subject_train.txt |  y_train.txt |  X_train.txt |

master_data <- data.frame()

subjects <- rbind(subject_test, subject_train)    # [10,299 x 1]
activities <- rbind(y_test, y_train)              # [10,299 x 1]
features <- rbind(X_test, X_train)                # [10,299 x 561]

## Convert the activity numbers to their respective descriptions
for (activity_number in activity_labels$ActivityID) {    
  activity_name <- activity_labels[activity_number, "ActivityName"]
  activities <- as.data.frame(sapply(activities, gsub, pattern = activity_number, replacement = activity_name))
}

## Choose only mean() and std() results (not meanFreq)
features <- features[, grepl("mean\\(\\)|std\\(\\)", feature_labels$Feature) ]

## Combine the columns to form our complete data set
master_data <- cbind(subjects, activities, features)

## Create a new data set with the average of each variable for each activity and each subject
#  ex. the mean for subject 1 doing activity 1, subject 1 doing activity 2...etc
#
# Subject       Activity    	tBodyAcc-mean()-X	tBodyAcc-mean()-Y	tBodyAcc-mean()-Z ....
#    1      walking                  [mean]              [mean]               [mean]
#    1      walking upstairs         [mean]              [mean]               [mean]
#    2      walking                  [mean]              [mean]               [mean]
#    2      walking upstairs         [mean]              [mean]               [mean]

means_data <- as_tibble(master_data)

## Aggregate the data under SubjectID and Activity and calculate the mean of each measurement
means_data <- means_data %>%
                         group_by(SubjectID, Activity) %>%
                         summarize_at(vars(everything()), mean)
 
## Save the average data set to file
write.table(means_data, "./data/tidy_means_data.txt", sep=",", row.name=FALSE)

## Delete what we downloaded
unlink(zipfile)