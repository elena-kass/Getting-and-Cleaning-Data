# Getting-and-Cleaning-Data
Final project for Coursera Getting and Cleaning Data course

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

Review criteria
1) The submitted data set is tidy.
2) The Github repo contains the required scripts.
3) GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4) The README that explains the analysis files is clear and understandable.
5) The work submitted for this project is the work of the student who submitted it.

Getting and Cleaning Data Course Projectless 
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This repository contains one analysis code titled run_analysis.R which performes the following steps:
1) Downloads the files from the source and reads them in R as tables.
2) Adds the feature labels found in features.txt to the data columns from trainX.txt and testX.txt
3) Merges the data files in order to obtain one long dataframe. The first column is subjectID, the second column is activity and the rest of the columns are the features being measured. The trainX and testX data has been merged together using rbind.
4) The mean and std values are extracted from the dataframe.
5) The activity is changed from numbers to descriptive variables
6) The feature labels are adjusted to be more tidy
7) A second dataframe Data2 is created that containes the average of each feature per activity and subject.

