Getting and Cleaning Data Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
The dataset being used is "Human Activity Recognition Using Smartphones Dataset".

The R script, run_analysis.R, does the following:

1. Download the file from the URL given and put the file in the given folder
2. Unzip the downloaded zip file
3. The list of files are in UCI HAR Dataset folder. To unzip the files that are in the folder
4. Read the Activity Files
5. Read the Subject Files
6. Read the Feature Files
7. Look at the properties of the above variable
8. Merges the training and the test sets to create one data set
9. Extracts only the measurements on the mean and standard deviation for each measurement
10. Uses descriptive activity names to name the activities in the data set
11. Appropriately labels the data set with descriptive variable names
12. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
