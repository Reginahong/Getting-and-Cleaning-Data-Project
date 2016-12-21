## Download the file from the URL given and put the file in the given folder
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data/Dataset.zip")
## Unzip the downloaded zip file
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
## The list of files are in UCI HAR Dataset folder. To unzip the files that are in the folder
path_UHD <- file.path("./data","UCI HAR Dataset")
files <- list.files(path_UHD, recursive = TRUE)
files
## Read the Activity Files
ActivityFilesTest <- read.table(file.path(path_UHD,"test","y_test.txt"),header = FALSE)
ActivityFilesTrain <- read.table(file.path(path_UHD,"train","y_train.txt"),header=FALSE)
## Read the Subject Files
SubjectFilesTest <- read.table(file.path(path_UHD,"test","subject_test.txt"),header = FALSE)
SubjectFilesTrain <- read.table(file.path(path_UHD,"train","subject_train.txt"),header = FALSE)
## Read the Feature Files
FeatureFilesTest <- read.table(file.path(path_UHD,"test","X_test.txt"),header = FALSE)
FeatureFilesTrain <- read.table(file.path(path_UHD,"train","X_train.txt"),header = FALSE)
## Look at the properties of the above variable
str(ActivityFilesTest)
str(ActivityFilesTrain)
str(SubjectFilesTest)
str(SubjectFilesTrain)
str(FeatureFilesTest)
str(FeatureFilesTrain)
## Merges the training and the test sets to create one data set
## 1. Concatenate the data tables by rows
Subjectdata <- rbind(SubjectFilesTest,SubjectFilesTrain)
Activitydata <- rbind(ActivityFilesTest,ActivityFilesTrain)
Featuredata <- rbind(FeatureFilesTest,FeatureFilesTrain)
## 2. Set name to variables
names(Subjectdata) <- c("Subject")
names(Activitydata) <- c("Activity")
FeatureName <- read.table(file.path(path_UHD, "features.txt"),header = FALSE)
names(Featuredata) <- FeatureName$V2
## Merge columns to get the data frame Data for all data
CombineData <- cbind(Subjectdata,Activitydata)
Data <- cbind(Featuredata,CombineData)
## Extracts only the measurements on the mean and standard deviation for each measurement.
FeatureNameSubData <- FeatureName$V2[grep("mean\\(\\)|std\\(\\)",FeatureName$V2)]
SelectedNames <- c(as.character(FeatureNameSubData),"Subject","Activity")
Data <- subset(Data,select = SelectedNames)
str(Data)
## Uses descriptive activity names to name the activities in the data set
## 1. Read descriptive activity names from "activity_labels.txt"
ActivityLabels <- read.table(file.path(path_UHD,"activity_labels.txt"),header = FALSE)
Data$Activity <- factor(Data$Activity)
Data$Activity <- factor(Data$Activity,labels = as.character(ActivityLabels$V2))
head(Data$Activity)
## Appropriately labels the data set with descriptive variable names.
names(Data) <- gsub("^t","time",names(Data))
names(Data) <- gsub("^f","frequency", names(Data))
names (Data) <- gsub ("Acc","Accelerometer",names(Data))
names(Data) <- gsub("Gyro", "Gyroscope",names(Data))
names(Data) <- gsub("Mag", "Magnitude",names(Data))
names(Data) <- gsub("BodyBody","Body",names(Data))
names(Data)
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
Data2 <- aggregate(.~Subject + Activity,Data,mean)
Data2 <- Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.names = FALSE)
