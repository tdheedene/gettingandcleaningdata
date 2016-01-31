## (updated) CodeBook - Getting and Cleaning Data project
## variables
* subject_ID (at the end of the dataset): numeric, identifies the subject person
* activity_name (at the end of the dataset): text, specifies the activity that was done during the measurement

The remaining variables are numeric and contain the following information:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* time and frequency domain variables

These variable names contain the following logic:
* first letter t: time domain variable
* first letter f: frequence domain variable
* 'Acc' stands for accelerometer
* 'Gyro' stands for gyroscope
* XY or -Z suffix: corresponding axis (either X, Y or Z)

measurements done:
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
* variable name suffix mean(): Mean value 
* variable name suffix std(): Standard deviation

## transformations
The data is read from the files (specified below) into separate dataframes. Column names are added using either hard coded values or read from a separate file.
in order to merge the separate dataframes into 1 dataframe (of 1 folder like test or train), a help-column called observation_ID was added. this value indicates the observation and is used to merge all the dataframes into 1 using merge statements. Merging the 2 dataframes that was composed by getting the data from the files in the train & test folders is done by the rbind funcion.

calculating the mean of the measurements per activity per subject is done by the aggregate function.

## data sources
the data is collected from the txt files in the train & test folder:
* activity_labels.txt contains the mapping of an activity code and an activity description
* features.txt contains the list of the measurements that were made
* 'train/X_train.txt': Training set (measurements of data)
* 'test/X_test.txt': test set (measurements of data)
* 'train/y_train.txt': training labels (indicates the activity)
* 'test/y_test.txt': test labels (indicates the activity)
* 'test/subject_test.txt': test subjects (person doing the activity that was measured)
* 'train/subject_train.txt': train subjects (person doing the activity that was measured)