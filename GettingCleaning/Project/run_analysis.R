setwd("/home/michael/Documents/Projects/Coursera/Data Science/GettingCleaning/Project")

# Loading in train and test data

#X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
#y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
#subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
#X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
#y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
#subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

X_all <- rbind(X_test, X_train)
y_all <- rbind(y_test, y_train)
subject_all <- rbind(subject_test, subject_train)