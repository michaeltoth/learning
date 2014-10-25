We begin with 6 raw raw files from the UCI HAR Dataset, X_test.txt, X_train.txt, y_test.txt, y_train.txt, features.txt, and activity_labels.txt.

After loading in files, we combine both the X_test.txt and X_train.txt files into the X_all data frame using the rbind command. Similarly, we combine the y_test.txt and y_train.txt files into the y_all data frame.

Next, we load in the features.txt and activity_labels.txt files from the UCI HAR Dataset. We add the features labeels from features.txt as headers to the X_all dataframe using the names command.

To extract only the features representing the mean and standard deviation of the variables, we make note of the fact that these all are formated similarly, either containing the text mean() or std() in the name. We use regular expression matching to extract only these variables, using the grep command. We then subset the X_all data frame to only contain these columns, storing the result in a new data frame, X_all_relevant.

Next, we work to add the activity names to our data set. We start by prepending the y_all data frame to the X_all_relevant data frame using the cbind function, storing the result in a new data frame, X_all_labeled. This adds a column with integer values ranging from 1-6. Next, we need to replace these integer values with their corresponding activity names. We do this by using the merge function, merging the X_all_labeled data frame with the activity_labels.txt file from above, where the common field is the integer values representing the activities. The result is stored in a new data frame, mergedData.

Now, we have a tidy data set that contains column labels corresponding only to mean and standard deviation of features and row labels corresponding to the associated activity. We can now easily use this tidy data set for analysis.

We use the aggregate function to apply the mean operation to all columns of our tidy data set, separately applying this function to each of the 6 activities. This results in an output that is 66 columns (corresponding to the 33 mean and 33 standard deviation features), and 6 rows (corresponding to the 6 activities). Each data point tells us the mean value of the corresponding feature (column name) across all observations of the specified activity (row name) in the data set.

We use the write.table function to write this output to a file called tidy.txt for submission.

Individual Column Name Descriptions as Below:

"Group.1"                     Activity name  
"tBodyAcc-mean()-X"           Average of tBodyAcc-mean()-X by activity  
"tBodyAcc-mean()-Y"           Average of tBodyAcc-mean()-Y by activity  
"tBodyAcc-mean()-Z"           Average of tBodyAcc-mean()-Z by activity  
"tBodyAcc-std()-X"            Average of tBodyAcc-std()-X by activity  
"tBodyAcc-std()-Y"            Average of tBodyAcc-std()-Y by activity  
"tBodyAcc-std()-Z"            Average of tBodyAcc-std()-Z by activity  
"tGravityAcc-mean()-X"        Average of tGravityAcc-mean()-X by activity  
"tGravityAcc-mean()-Y"        Average of tGravityAcc-mean()-Y by activity  
"tGravityAcc-mean()-Z"        Average of tGravityAcc-mean()-Z by activity  
"tGravityAcc-std()-X"         Average of tGravityAcc-std()-X by activity  
"tGravityAcc-std()-Y"         Average of tGravityAcc-std()-Y by activity  
"tGravityAcc-std()-Z"         Average of tGravityAcc-std()-Z by activity  
"tBodyAccJerk-mean()-X"       Average of tBodyAccJerk-mean()-X by activity  
"tBodyAccJerk-mean()-Y"       Average of tBodyAccJerk-mean()-Y by activity  
"tBodyAccJerk-mean()-Z"       Average of tBodyAccJerk-mean()-Z by activity  
"tBodyAccJerk-std()-X"        Average of tBodyAccJerk-std()-X by activity  
"tBodyAccJerk-std()-Y"        Average of tBodyAccJerk-std()-Y by activity  
"tBodyAccJerk-std()-Z"        Average of tBodyAccJerk-std()-Z by activity  
"tBodyGyro-mean()-X"          Average of tBodyGyro-mean()-X by activity  
"tBodyGyro-mean()-Y"          Average of tBodyGyro-mean()-Y by activity  
"tBodyGyro-mean()-Z"          Average of tBodyGyro-mean()-Z by activity  
"tBodyGyro-std()-X"           Average of tBodyGyro-std()-X by activity  
"tBodyGyro-std()-Y"           Average of tBodyGyro-std()-Y by activity  
"tBodyGyro-std()-Z"           Average of tBodyGyro-std()-Z by activity  
"tBodyGyroJerk-mean()-X"      Average of tBodyGyroJerk-mean()-X by activity  
"tBodyGyroJerk-mean()-Y"      Average of tBodyGyroJerk-mean()-Y by activity  
"tBodyGyroJerk-mean()-Z"      Average of tBodyGyroJerk-mean()-Z by activity  
"tBodyGyroJerk-std()-X"       Average of tBodyGyroJerk-std()-X by activity  
"tBodyGyroJerk-std()-Y"       Average of tBodyGyroJerk-std()-Y by activity  
"tBodyGyroJerk-std()-Z"       Average of tBodyGyroJerk-std()-Z by activity  
"tBodyAccMag-mean()"          Average of tBodyAccMag-mean() by activity  
"tBodyAccMag-std()"           Average of tBodyAccMag-std() by activity  
"tGravityAccMag-mean()"       Average of tGravityAccMag-mean() by activity  
"tGravityAccMag-std()"        Average of tGravityAccMag-std() by activity  
"tBodyAccJerkMag-mean()"      Average of tBodyAccJerkMag-mean() by activity  
"tBodyAccJerkMag-std()"       Average of tBodyAccJerkMag-std() by activity  
"tBodyGyroMag-mean()"         Average of tBodyGyroMag-mean() by activity  
"tBodyGyroMag-std()"          Average of tBodyGyroMag-std() by activity  
"tBodyGyroJerkMag-mean()"     Average of tBodyGyroJerkMag-mean() by activity  
"tBodyGyroJerkMag-std()"      Average of tBodyGyroJerkMag-std() by activity  
"fBodyAcc-mean()-X"           Average of fBodyAcc-mean()-X by activity  
"fBodyAcc-mean()-Y"           Average of fBodyAcc-mean()-Y by activity  
"fBodyAcc-mean()-Z"           Average of fBodyAcc-mean()-Z by activity  
"fBodyAcc-std()-X"            Average of fBodyAcc-std()-X by activity  
"fBodyAcc-std()-Y"            Average of fBodyAcc-std()-Y by activity  
"fBodyAcc-std()-Z"            Average of fBodyAcc-std()-Z by activity  
"fBodyAccJerk-mean()-X"       Average of fBodyAccJerk-mean()-X by activity  
"fBodyAccJerk-mean()-Y"       Average of fBodyAccJerk-mean()-Y by activity  
"fBodyAccJerk-mean()-Z"       Average of fBodyAccJerk-mean()-Z by activity  
"fBodyAccJerk-std()-X"        Average of fBodyAccJerk-std()-X by activity  
"fBodyAccJerk-std()-Y"        Average of fBodyAccJerk-std()-Y by activity  
"fBodyAccJerk-std()-Z"        Average of fBodyAccJerk-std()-Z by activity  
"fBodyGyro-mean()-X"          Average of fBodyGyro-mean()-X by activity  
"fBodyGyro-mean()-Y"          Average of fBodyGyro-mean()-Y by activity  
"fBodyGyro-mean()-Z"          Average of fBodyGyro-mean()-Z by activity  
"fBodyGyro-std()-X"           Average of fBodyGyro-std()-X by activity  
"fBodyGyro-std()-Y"           Average of fBodyGyro-std()-Y by activity  
"fBodyGyro-std()-Z"           Average of fBodyGyro-std()-Z by activity  
"fBodyAccMag-mean()"          Average of fBodyAccMag-mean() by activity  
"fBodyAccMag-std()"           Average of fBodyAccMag-std() by activity  
"fBodyBodyAccJerkMag-mean()"  Average of fBodyBodyAccJerkMag-mean() by activity  
"fBodyBodyAccJerkMag-std()"   Average of fBodyBodyAccJerkMag-std() by activity  
"fBodyBodyGyroMag-mean()"     Average of fBodyBodyGyroMag-mean() by activity  
"fBodyBodyGyroMag-std()"      Average of fBodyBodyGyroMag-std() by activity  
"fBodyBodyGyroJerkMag-mean()" Average of fBodyBodyGyroJerkMag-mean() by activity  
"fBodyBodyGyroJerkMag-std()"  Average of fBodyBOdyGyroJerkMag-std() by activity  

