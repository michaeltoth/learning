setwd("/home/michael/Documents/Projects/Coursera/Data Science/GettingCleaning/Project")

# Loading in train and test data
#X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
#y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
#subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
#X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
#y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
#subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Combining test and training datasets
X_all <- rbind(X_test, X_train)
y_all <- rbind(y_test, y_train)
subject_all <- rbind(subject_test, subject_train)

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

# Add activity lables from y_all file
X_all_labeled <- cbind(y_all, X_all_relevant)
colnames(X_all_labeled)[1] <- "Activity"

# Merge the activity names from y with the activity labels in X to form data set
mergedData <- merge(X_all_labeled, activities,by.x="Activity", 
                    by.y="V1",all=TRUE)[,-1]

colnames(mergedData)[67] <- "Activity"
