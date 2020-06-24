### Project assignment for Getting and Cleaning Data course on Coursera
### The purpose of this project is to demonstrate your ability to collect, work with, and clean 
### a data set. The goal is to prepare tidy data that can be used for later analysis. You will be 
### graded by your peers on a series of yes/no questions related to the project. You will be 
### required to submit: 1) a tidy data set as described below, 2) a link to a Github repository 
### with your script for performing the analysis, and 3) a code book that describes the variables,
### the data, and any transformations or work that you performed to clean up the data called 
### CodeBook.md. You should also include a README.md in the repo with your scripts. This repo 
### explains how all of the scripts work and how they are connected.

###_____________________________________________________________________
### Step 1: Read the files
###_____________________________________________________________________
# Create directory where extracted data will be stored
if(!file.exists("./data")){dir.create("./data")}

# Download data from server
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

#unzip data and store it in folder "data"
unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", exdir="./data")

## files to be read: x_train.txt,x_test.txt,y_train.txt,y_test.txt,subject_train.txt,
##  subject_test.txt, features.txt, activity_labels.txt

trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
trainY <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
testY <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

###_____________________________________________________________________
### Step 2: Add labels to the columns of the data files
###_____________________________________________________________________
## The columns of trainX and trainY (data files) are given by the second column of the features
## Using names, the columns are appropriately labeled
names(trainX) <- features$V2
names(testX) <- features$V2

###_____________________________________________________________________
### Step 3: Merge appropriate files
###_____________________________________________________________________
## Rationale: After looking at the data, I realized that both the train and the test dataset have
## all the same columns (features). I will create a tidy dataframe that will merge the train and 
## test data sets on top of each other and create an identifier for "Train" and "Test"

##Cbind all the train related data in one df. subject_train/test holds the ID of the subjects, 
## train/testY holds the activity type and train/testX holds the data
library(dplyr)
subject_train <- rename(subject_train, subjectID = "V1")
trainY <- rename(trainY, activity = "V1")
TrainData <- cbind(subject_train, trainY, trainX)

subject_test <- rename(subject_test, subjectID = "V1")
testY <- rename(testY, activity = "V1")
TestData <- cbind(subject_test, testY, testX)

## The dataframe Data contains all the train and test data. The first column is the subjectID, 
## the second column is the activity type and the rest of the columns are the features.
Data <- rbind(TrainData, TestData)

###_____________________________________________________________________
### Step 4: Extract only mean and std measurements from Data
###_____________________________________________________________________
## The assignment asks us to extract the data that looks at mean and std from each feature.

#Need to add +2 to account for the columns of subjectID and activity
mean_indices <- grep("-mean\\(\\)", features$V2) + 2
std_indices <- grep("std()", features$V2) + 2

#Use indices identified above, in addition to 1 (subjectID), 2 (activity)
indices <- c(1,2,mean_indices, std_indices)
Data1 <- Data[,indices]

###_____________________________________________________________________
### Step 5: Add descriptive variables for the activity
###_____________________________________________________________________
# Adjust the descriptions in the dataframe activity_labels
# First, fix the words in activity_labels by removing the "_" and all caps.
activity_labels$V2 <- gsub("_", " ", activity_labels$V2, fixed=TRUE)
activity_labels$V2 <- tolower(activity_labels$V2)

#USe recode function to replace the numbers with the descriptive activity
Data1$activity <- recode(Data1$activity, '1' = activity_labels[1,2], '2' = activity_labels[2,2],
                         '3' = activity_labels[3,2], '4' = activity_labels[4,2], '5' = activity_labels[5,2],
                         '6' = activity_labels[6,2])

Data1$activity <- as.factor(Data1$activity)

###_____________________________________________________________________
### Step 6: Appropriately labels the data set with descriptive variable names.
###_____________________________________________________________________
## Adjust the descriptions in the dataframe Data1 using gsub. According to lecture, we should be
## as descriptive as possible eg "Diagnosis" versus "Dx". I have expanded some of the words.

names(Data1)<-gsub("^t", "Time", names(Data1))
names(Data1)<-gsub("^f", "Frequency", names(Data1))
names(Data1)<-gsub("Gyro", "Gyroscope", names(Data1))
names(Data1)<-gsub("Acc", "Accelerometer", names(Data1))
names(Data1)<-gsub("Mag", "Magnitude", names(Data1))
names(Data1)<-gsub("BodyBody", "Body", names(Data1)) #not sure if the BodyBody is a mistake
names(Data1)<-gsub("[()]", "", names(Data1))

###_____________________________________________________________________
### Step 7: From the data set in step 4, creates a second, independent tidy data set with the
### average of each variable for each activity and each subject.
###_____________________________________________________________________
Data1 <- tbl_df(Data1)
Data2 <- Data1 %>% 
        group_by(subjectID, activity) %>% 
        summarise_each(funs(mean))

write.table(Data2, "tidy_dataset_average.txt", row.names = F, col.names= T, sep = "\t")
            