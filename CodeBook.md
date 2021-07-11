### CodeBook

This data was extracted from a fitness study of the accelerometers in the Samsung Galaxy S smartphone:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

### Subjects

There were 30 subjects that performed activities. The IDs for each subject that performed a given activity that was measured are contained in *subject_test.txt*, which has 2,947 observations and in *subject_train.txt* which has 7,352 observations.

### Activities

There were 6 activities that the subjects carried out. The activity IDs and labels are in *activity_labels.txt*.

1. walking
2. walking upstairs
3. walking downstairs
4. sitting
5. standing
6. laying

### Measurements and Labels

The activity that was performed for each measurement is in the "Y" file. The associated measurements are in the corresponding "X" file - e.g. *y_train.txt* contains a list of the activities for each observation in *X_train.txt*. 

### Putting it All Together

There are 2 data frames created using this data - *master_data* and *means_data*.

#### master_data

This data frame contains all the mean() and std() measurements for each subject, each time they performed an activity.

*Sample:*

| SubjectID | Activity | tBodyAcc-mean()-X | tBodyAcc-mean()-Y | tBodyAcc-mean()-Z | tBodyAcc-std()-X |
| --------- | -------- | ----------------- | ----------------- | ----------------- | ---------------- |
|         2 | standing |     0.2571778     |    -0.02328523    |   -0.01465376     |    -0.9384040    |
|         2 | standing |     0.2860267     |    -0.01316336    |   -0.11908252     |    -0.9754147    |
|         2 | standing |     0.2754848     |    -0.02605042    |   -0.11815167     |    -0.9938190    |
|         2 | standing |     0.2702982     |    -0.03261387    |   -0.11752018     |    -0.9947428    |
|         2 | standing |     0.2748330     |    -0.02784779    |   -0.12952716     |    -0.9938525    |

*Data:*

- Subject
- Activity    
- tBodyAcc-mean()-X	
- tBodyAcc-mean()-Y	
- tBodyAcc-mean()-Z	
- tBodyAcc-std()-X	
- tBodyAcc-std()-Y	
- tBodyAcc-std()-Z	
- tGravityAcc-mean()-X
- tGravityAcc-mean()-Y	
- tGravityAcc-mean()-Z	
- tGravityAcc-std()-X	
- tGravityAcc-std()-Y	
- tGravityAcc-std()-Z	
- tBodyAccJerk-mean()-X	
- tBodyAccJerk-mean()-Y	
- tBodyAccJerk-mean()-Z	
- tBodyAccJerk-std()-X	
- tBodyAccJerk-std()-Y	
- tBodyAccJerk-std()-Z	
- tBodyGyro-mean()-X	
- tBodyGyro-mean()-Y	
- tBodyGyro-mean()-Z	
- tBodyGyro-std()-X	
- tBodyGyro-std()-Y	
- tBodyGyro-std()-Z	
- tBodyGyroJerk-mean()-X	
- tBodyGyroJerk-mean()-Y	
- tBodyGyroJerk-mean()-Z	
- tBodyGyroJerk-std()-X	
- tBodyGyroJerk-std()-Y	
- tBodyGyroJerk-std()-Z	
- tBodyAccMag-mean()	
- tBodyAccMag-std()	
- tGravityAccMag-mean()	
- tGravityAccMag-std()	
- tBodyAccJerkMag-mean()	
- tBodyAccJerkMag-std()	
- tBodyGyroMag-mean()	
- tBodyGyroMag-std()	
- tBodyGyroJerkMag-mean()	
- tBodyGyroJerkMag-std()	
- fBodyAcc-mean()-X	
- fBodyAcc-mean()-Y	
- fBodyAcc-mean()-Z	
- fBodyAcc-std()-X	
- fBodyAcc-std()-Y	
- fBodyAcc-std()-Z	
- fBodyAccJerk-mean()-X	
- fBodyAccJerk-mean()-Y	
- fBodyAccJerk-mean()-Z	
- fBodyAccJerk-std()-X	
- fBodyAccJerk-std()-Y	
- fBodyAccJerk-std()-Z	
- fBodyGyro-mean()-X	
- fBodyGyro-mean()-Y	
- fBodyGyro-mean()-Z	
- fBodyGyro-std()-X	
- fBodyGyro-std()-Y	
- fBodyGyro-std()-Z	
- fBodyAccMag-mean()	
- fBodyAccMag-std()	
- fBodyBodyAccJerkMag-mean()	
- fBodyBodyAccJerkMag-std()	
- fBodyBodyGyroMag-mean()	
- fBodyBodyGyroMag-std()	
- fBodyBodyGyroJerkMag-mean()	
- fBodyBodyGyroJerkMag-std()

#### means_data

This data frame contains the mean for each measurement, for each activity performed by a subject.

*Sample:*

| SubjectID |      Activity      | tBodyAcc-mean()-X | tBodyAcc-mean()-Y | tBodyAcc-mean()-Z | tBodyAcc-std()-X |
| --------- | ------------------ | ----------------- | ----------------- | ----------------- | ---------------- |
|         1 |            walking |     0.2773308     |    -0.017383819   |     -0.1111481    |    -0.28374026   |
|         1 |   walking upstairs |     0.2554617     |    -0.023953149   |     -0.0973020    |    -0.35470803   |
|         1 | walking downstairs |     0.2891883     |    -0.009918505   |     -0.1075662    |     0.03003534   |
|         1 |            sitting |     0.2612376     |    -0.001308288   |     -0.1045442    |    -0.97722901   |
|         1 |           standing |     0.2789176     |    -0.016137590   |     -0.1106018    |    -0.99575990   |
|         1 |             laying |     0.2215982     |    -0.040513953   |     -0.1132036    |    -0.92805647   |
|         2 |            walking |     0.2764266     |    -0.018594920   |     -0.1055004    |    -0.42364284   |
|         2 |   walking upstairs |     0.2471648     |    -0.021412113   |     -0.1525139    |    -0.30437641   |
|         2 | walking downstairs |     0.2776153     |    -0.022661416   |     -0.1168129    |     0.04636668   |
|         2 |            sitting |     0.2770874     |    -0.015687994   |     -0.1092183    |    -0.98682228   |
|         2 |           standing |     0.2779115     |    -0.018420827   |     -0.1059085    |    -0.98727189   |
|         2 |             laying |     0.2813734     |    -0.018158740   |     -0.1072456    |    -0.97405946   |

