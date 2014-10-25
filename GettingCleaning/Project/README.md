# Getting and Cleaning Data Course Project

The run_analysis.R script reads in 4 files from the UCI HAR Dataset, *X_test.txt*,
*X_train.txt*,*y_test.txt*, and *y_train.txt*.  The UCI HAR Dataset directory
should be a subdirectory within the directory where run_analysis.R is stored.  

After loading in files, we combine both the *X_test.txt* and *X_train.txt* files
into the *X_all* data frame using the rbind command.  Similarly, we combine the
*y_test.txt* and *y_train.txt* files into the *y_all* data frame.  

Next, we load in the *features.txt* and *activity_labels.txt* files from the UCI
HAR Dataset.  We add the features labeels from *features.txt* as headers to the
*X_all* dataframe using the names command.  

To extract only the features representing the mean and standard deviation of the
variables, we make note of the fact that these all are formmated similarly, 
either containing the text mean() or std() in the name.  We use regular expression
matching to extract only these variables, using the grep command.  We then subset
the *X_all* data frame to only contain these columns, storing the result in a new
data frame, *X_all_relevant*.  

Next, we work to add the activity names to our data set.  We start by prepending
the *y_all* data frame to the *X_all_relevant* data frame using the cbind function,
storing the result in a new data frame, *X_all_labeled*.  This adds a column with
integer values ranging from 1-6.  Next, we need to replace these integer values
with their corresponding activity names.  We do this by using the merge function,
merging the *X_all_labeled* data frame with the *activity_labels.txt* file from 
above, where the common field is the integer values representing the activities.
The result is stored in a new data frame, *mergedData*.

Now, we have a tidy data set that contains column labels corresponding only to 
mean and standard deviation of features and row labels corresponding to the
associated activity.  We can now easily use this tidy data set for analysis.

We use the aggregate function to apply the mean operation to all columns of our
tidy data set, separately applying this function to each of the 6 activities.
This results in an output that is 66 columns (corresponding to the 33 mean and
33 standard deviation features), and 6 rows (corresponding to the 6 activities).  

We use the write.table function to write this output to a file called *tidy.txt* 
for submission.
