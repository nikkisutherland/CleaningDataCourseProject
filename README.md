# Cleaning Data Project

Course project for Getting and Cleaning Data 

#### CodeBook.Rmd

The CodeBook describe in detail the data used in the *run_analysis.R* script.


#### run_analysis.R

This script takes the resulting data sets from a fitness study of the 
accelerometers in the Samsung Galaxy S smartphone:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Using these data sets, the script does the following:

 1. Downloads the data into a *data* directory
 2. Cleans up the activity labels: makes them lowercase and removes the "_"
 3. Sets the headers for *X_test.txt* and *X_train.txt* to the feature labels
 4. Stacks *subject_test.txt* on top of *subject_train.txt*
 5. Stacks *y_test.txt* on top of *y_train.txt* (these are the IDs for the activity performed in each observation)
 6. Replaces the activity IDs with their respective names
 7. Stacks *X_test.txt* on top of *X_train.txt*
 8. Extracts only the measurements on the mean and standard deviation for each measurement (does not include meanFreq)
 9. Column binds subjects, activities (y files), and the measurements (X files) into *master_data*
 10. From *master_data*, creates a second, independent data frame called *means_data*, with the average of each measurement for each activity and each subject.
 11. Saves the tidy means data as *tidy_means_data.txt*
 12. Deletes the downloaded data
 
Note: This script uses dplyr.
