# Loading in train and test data
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")


# Combining test and training datasets
X_all <- rbind(X_test, X_train)
y_all <- rbind(y_test, y_train)
subject_all <- rbind(sub_test, sub_train)

# Read in feature names and activity names
features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# Adding names to the X_all dataset from the features file
names(X_all) <- features$V2

# Use grep and regular expressions to extract mean and std features
toMatch <- c("mean\\(\\)", "std\\(\\)")
matches <- grep(paste(toMatch,collapse="|"),features$V2,value=TRUE)

# Extract only the measurements on the mean and standard deviation
X_all_relevant <- X_all[,matches]

# Add activity and subject labels from y_all file and subject_all file
X_all_labeled <- cbind(y_all, subject_all, X_all_relevant)
colnames(X_all_labeled)[1:2] <- c("Activity","Subject")

# NEED TO ADD DESCRIPTIVE LABELS FOR OTHERS

# Merge the activity names from y with the activity labels in X as descriptors
mergedData <- merge(X_all_labeled, activities,by.x="Activity", 
                    by.y="V1",all=TRUE)[,-1]
colnames(mergedData)[68] <- "Activity"

# Determine mean of each feature by activity and subject:
output <- aggregate(mergedData[,2:67],
            by=list(mergedData$Activity,mergedData$Subject),
            mean)
colnames(output)[1:2] <- c("Activity","Subject")

# Add descriptive labels to dataset:
colnames(output) <- sub("^t", "Time ", colnames(output))
colnames(output) <- sub("^f", "Frequency ", colnames(output))
colnames(output) <- sub("Gyro", " Gyroscope ", colnames(output))
colnames(output) <- sub("Acc", " Accelerometer ", colnames(output))
colnames(output) <- sub("-mean\\(\\)", "Mean ", colnames(output))
colnames(output) <- sub("-std\\(\\)", "SD ", colnames(output))
colnames(output) <- sub("Jerk", "Jerk ", colnames(output))
colnames(output) <- sub("Mag", "Magnitude ", colnames(output))

write.table(output, file = "tidy.txt", row.names=FALSE)
