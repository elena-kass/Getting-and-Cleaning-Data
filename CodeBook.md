This code book  describes the variables, the data, and any transformations or work that was performed to clean up the data.

The original data was been downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
In this zip-folder, there is a README.txt file which explains what each individual text files are.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features, there are 561 features total.

- 'activity_labels.txt': Links the class labels with their activity name, there are 6 activities total.

- 'train/X_train.txt': Training set, containes 7352 observations.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set, contains 2947 observations.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

To tidy the data, I have performed the following steps:
1) Created a dataframe called Data where
     -  first column is the "subjectID" (numeric): subject.train followed by subject.test. There are a total of 30 participants so the values range from 1 to 30.
     -  second column is the "activity" (factor): describes which activity the subject was performing. The data for this is originally found in trainY.txt and testY.txt.                                                          Initialy this data was given as numeric 1:6 in each of the text files. 
     -  columns 3 to 561 (numeric) : these columns represent the features found in trainX.txt and testX.txt. The labels for each feature were initially found in a separate text                                      file titled features.txt. I have added the feature labels as column names.
     *** Data dataframe is NOT tidy!!
     
  2) Since the assignment asked to subset the dataframe to only contain mean and std values of the features, I have created a second dataframe called Data1 where:
     - first column is the "subjectID" (numeric): subject.train followed by subject.test. There are a total of 30 participants so the values range from 1 to 30.
     - secoond column is the "activity" (factor): describes which activity the subject was performing. The data for this is originally found in trainY.txt and testY.txt.There                                                     are 6 levels. Initialy this data was given as numeric 1:6 in each of the text files. The labels for each number were given in a                                                   separate table titled activity_labels.txt. I have changed the activity labels to remove underscore, I have added a space                                                         between the words and have converted everything to lower case. The activity is now converted to a descriptive variable. I have                                                   combined trainY.txt and testY.txt into one file using rbind.
      columns 3 to 68 (numeric) : these columns represent the features found in trainX.txt and testX.txt that correspond to mean and std values. The labels for each feature were                                   initially found in a separate text file titled features.txt. I have added the feature labels as column names and have changed the names to make                                   them more readable and tidy. The main changes involve expanind "t" to time, "f" to frequence, "Acc" to accelerometer, "mag" to magnitude,                                         "Gyro" to gyrometer. I have also removed "()". More information on the features can be found below. 
      *** Data1 dataframe is the tidy version of the dataset that we are looking for.
    
  3) Since the assignment asked us to create another dataframe that shoes the average of each feature as a function of activity and subjectID, I have created a dataframe called Data2 where the average of the 65 features that are part of D1 is calculated and grouped as a function of subjectID and activity.
  
More information on feature selection:
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

For our tidy dataframe, we are only interested in the mean() and std() values of the following features:
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The name of the features were further modified so that t = Time, f = Frequence, Acc = Accelerator, Gyro = Gyrometer, Mag = Magnitude.
