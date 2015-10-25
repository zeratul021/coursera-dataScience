### Course Project fo https://class.coursera.org/getdata-033
### @author Marek Sabo
###
### You should create one R script called run_analysis.R that does the following. 
### Merges the training and the test sets to create one data set.
### Extracts only the measurements on the mean and standard deviation for each measurement. 
### Uses descriptive activity names to name the activities in the data set
### Appropriately labels the data set with descriptive variable names. 
### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## PROLOGUE
## load the libs
library(dplyr)

## check the env
getwd()
#setwd("~/projects/coursera/coursera-dataScience/03-getdata/courseProject")
## dir.exists for R3.2
stopifnot(file.info("UCI HAR Dataset")[1,"isdir"])

## Load all required data (subject, test and train datasets, activity labels)
trainSubject = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header = F)
trainFeatures = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header = F)
trainLabels = read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header = F)
stopifnot(nrow(trainSubject) == nrow(trainFeatures) & nrow(trainSubject) == nrow(trainLabels))

testSubject = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header = F)
testFeatures = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header = F)
testLabels = read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header = F)
stopifnot(nrow(testSubject) == nrow(testFeatures) & nrow(testSubject) == nrow(testLabels))

activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header = F)
featureLabels = read.csv("UCI HAR Dataset/features.txt", sep="", header = F)

## CHAPTER 1
## merge the train and test datasets
trainData = cbind(trainSubject, trainLabels, trainFeatures) 
typeof(trainData)

testData = cbind(testSubject, testLabels, testFeatures) 
typeof(testData)
## unfortunatelly featuresNames contain invalid characters (R column naming conventions)
featureNames = lapply(as.character(featureLabels[, 2]), function(x){gsub("\\(|\\)", "", gsub("-", "_", x))})
allColumnNames = make.names(c("subject", "activity", featureNames), unique = T, allow_ = T)
allData = rbind(trainData, testData)
colnames(allData) = allColumnNames
names(allData)
stopifnot(nrow(allData) == nrow(trainData) + nrow(testData) & ncol(allData) == ncol(trainData) & ncol(allData) == ncol(testData))

## CHAPTER 2
## project only means and SDs
## feature names use suffixes to denote their type but we had to lose them as they can't be handled by dplyr
allData = select(allData, matches("subject"), matches("activity"), contains("mean", ignore.case = T), contains("std", ignore.case = T))
names(allData)
## optional: if we wanna to go all literal on the dataset then eliminate derived leftovers
## (not my idea :/ saw it in the forums)
#allData = select(allData, -contains("freq", ignore.case = T), -contains("angle", ignore.case = T))

## CHAPTER 3
## replace the activity codes with the actual labels
mutate(allData, activity = )

## CHAPTER 4
## already happened in CHAPTER 1

## CHAPTER 5
## let's get averages for all means and SDs per subejct and activity
allDataMeans = allData %>% group_by(subject, activity) %>% summarise_each(funs(mean))

## EPILOGUE
write.table(allDataMeans, file="allDataMeans.txt", row.name = F)
