#
# This script:
#
#    Merges the training and the test sets to create one data set.
#    Extracts only the measurements on the mean and standard deviation for each measurement. 
#
#	Uses descriptive activity names to name the activities in the data set
#
#	Appropriately labels the data set with descriptive variable names. 
#
#    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("D:/datascience")

#Install the "Reshape2" package so we can use "melt"
install.packages("reshape2")
library(reshape2)

#Load test set
testData <- read.table("uci/test/X_test.txt", sep = "" , header = FALSE)
#Load training set
trainData <- read.table("uci/train/X_train.txt", sep = "" , header = FALSE)
#Load features
features <- read.table("uci/features.txt", sep = "" , header = FALSE)
#Load activities
activities <- read.table("uci/activity_labels.txt", sep = "", header = FALSE)
#Load subjects and activities
testSubjects <- read.table("uci/test/subject_test.txt", sep = "", header = FALSE)
trainSubjects <- read.table("uci/train/subject_train.txt", sep = "", header = FALSE)
subjects = merge(testSubjects, trainSubjects, all=TRUE)
subjectActivitiesAll <- merge(activities,subjects, all=TRUE)
subjectActivities <- unique(subjectActivitiesAll)

#Merge the test and training data
mergedData = merge(trainData, testData, all=TRUE)
#Get the feature IDs for mean and standard-deviation only
featureIDs <- c(features[grep("mean", features$V2), 1], features[grep("std", features$V2), 1])
requiredMeasures <- mergedData[featureIDs]
#Assign meaningful names to the data
colnames(subjectActivities) <- c("activityLabel","activityName")
# Now clean the data using melt
cleanData <- melt(mergedData)
# Write out the cleaned data to a text file for upload to Github
write.table(cleanData, "uci/cleanData.txt", row.names = FALSE, quote = FALSE)
