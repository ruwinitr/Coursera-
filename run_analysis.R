


library(dplyr)

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

subject_test

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

features

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

activities



x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

x_test

head(x_test)

str(x_test)


y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

str(y_test)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

head(subject_train)

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



X <- rbind(x_train, x_test)

Y <- rbind(y_train, y_test)

str(Merged_Data)


head(Merged_Data)


TidyData_Set <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


head(TidyData_Set)

TidyData_Set$code <- activities[TidyData_Set$code, 2]

names(TidyData_Set)<-gsub("Acc", "Accelerometer", names(TidyData_Set))

names(TidyData_Set)[2] = "activity"

names(TidyData_Set)<-gsub("^f", "Frequency", names(TidyData_Set))

names(TidyData_Set)<-gsub("BodyBody", "Body", names(TidyData_Set))

names(TidyData_Set)<-gsub("Gyro", "Gyroscope", names(TidyData_Set))

names(TidyData_Set)<-gsub("gravity", "Gravity", names(TidyData_Set))

names(TidyData_Set)<-gsub("Mag", "Magnitude", names(TidyData_Set))

names(TidyData_Set)<-gsub("-std()", "STD", names(TidyData_Set), ignore.case = TRUE)

names(TidyData_Set)<-gsub("^t", "Time", names(TidyData_Set))

names(TidyData_Set)<-gsub("tBody", "TimeBody", names(TidyData_Set))

names(TidyData_Set)<-gsub("-mean()", "Mean", names(TidyData_Set), ignore.case = TRUE)

names(TidyData_Set)<-gsub("-freq()", "Frequency", names(TidyData_Set), ignore.case = TRUE)

names(TidyData_Set)<-gsub("angle", "Angle", names(TidyData_Set))


FinalData_Set <- TidyData_Set %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

str(FinalData_Set)

head(FinalData_Set)

write.table(TidyData_Set, "FinalTidyDataSet.txt", row.name=FALSE)