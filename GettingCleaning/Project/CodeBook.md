####Project Codebook

We begin with 8 raw raw files from the UCI HAR Dataset, *X_test.txt*, *X_train.txt*, *y_test.txt*, *y_train.txt*, *subject_test.txt*, *subject_train.txt*, *features.txt*, and *activity_labels.txt*.

After loading in files, we combine both the X_test.txt and X_train.txt files into the X_all data frame using the rbind command. Similarly, we combine the y_test.txt and y_train.txt files into the y_all data frame.

Next, we load in the features.txt and activity_labels.txt files from the UCI HAR Dataset. We add the features labeels from features.txt as headers to the X_all dataframe using the names command.

To extract only the features representing the mean and standard deviation of the variables, we make note of the fact that these all are formated similarly, either containing the text mean() or std() in the name. We use regular expression matching to extract only these variables, using the grep command. We then subset the X_all data frame to only contain these columns, storing the result in a new data frame, X_all_relevant.

Next, we add the activity and subject values to our data frame using the cbind command. Next, we work to add the activity names to our data set. We start by prepending the y_all data frame to the X_all_relevant data frame using the cbind function, storing the result in a new data frame, X_all_labeled. This adds a column with integer values ranging from 1-6. Next, we need to replace these integer values with their corresponding activity names. We do this by using the merge function, merging the X_all_labeled data frame with the activity_labels.txt file from above, where the common field is the integer values representing the activities. The result is stored in a new data frame, mergedData.

Now, we have a tidy data set that contains column labels corresponding only to mean and standard deviation of features and row labels corresponding to the associated activity and subject. We can now easily use this tidy data set for analysis.

We use the aggregate function to apply the mean operation to all columns of our tidy data set, separately applying this function to each of the 6 activities. This results in an output that is 66 columns (corresponding to the 33 mean and 33 standard deviation features), and 180 rows (corresponding to the 6 activities across 30 subjects). Each data point tells us the mean value of the corresponding feature (column name) across all observations of the specified activity for a given subject in the data set.

We use the write.table function to write this output to a file called tidy.txt for submission.

Individual Column Name Descriptions as Below:

| ####Column Header                                      | ####Description of Column               |
| -------------------------------------------------------| ----------------------------------------|
| "Activity"                                             | Activity Performed                      |
| "Subject"                                              | Subject in Study                        |
| "Time Body Accelerometer Mean -X"                      | Average of Field by Subject And Activity|
| "Time Body Accelerometer Mean -Y"                      | Average of Field by Subject And Activity|
| "Time Body Accelerometer Mean -Z"                      | Average of Field by Subject And Activity|
| "Time Body Accelerometer SD -X"                        | Average of Field by Subject And Activity|
| "Time Body Accelerometer SD -Y"                        | Average of Field by Subject And Activity|
| "Time Body Accelerometer SD -Z"                        | Average of Field by Subject And Activity|
| "Time Gravity Accelerometer Mean -X"                   | Average of Field by Subject And Activity|
| "Time Gravity Accelerometer Mean -Y"                   | Average of Field by Subject And Activity|
| "Time Gravity Accelerometer Mean -Z"                   | Average of Field by Subject And Activity|
| "Time Gravity Accelerometer SD -X"                     | Average of Field by Subject And Activity|
| "Time Gravity Accelerometer SD -Y"                     | Average of Field by Subject And Activity|
| "Time Gravity Accelerometer SD -Z"                     | Average of Field by Subject And Activity|
| "Time Body Accelerometer Jerk Mean -X"                 | Average of Field by Subject And Activity|
| "Time Body Accelerometer Jerk Mean -Y"                 | Average of Field by Subject And Activity|
| "Time Body Accelerometer Jerk Mean -Z"                 | Average of Field by Subject And Activity|
| "Time Body Accelerometer Jerk SD -X"                   | Average of Field by Subject And Activity|
| "Time Body Accelerometer Jerk SD -Y"                   | Average of Field by Subject And Activity|
| "Time Body Accelerometer Jerk SD -Z"                   | Average of Field by Subject And Activity|
| "Time Body Gyroscope Mean -X"                          | Average of Field by Subject And Activity|
| "Time Body Gyroscope Mean -Y"                          | Average of Field by Subject And Activity|
| "Time Body Gyroscope Mean -Z"                          | Average of Field by Subject And Activity|
| "Time Body Gyroscope SD -X"                            | Average of Field by Subject And Activity|
| "Time Body Gyroscope SD -Y"                            | Average of Field by Subject And Activity|
| "Time Body Gyroscope SD -Z"                            | Average of Field by Subject And Activity|
| "Time Body Gyroscope Jerk Mean -X"                     | Average of Field by Subject And Activity|
| "Time Body Gyroscope Jerk Mean -Y"                     | Average of Field by Subject And Activity|
| "Time Body Gyroscope Jerk Mean -Z"                     | Average of Field by Subject And Activity|
| "Time Body Gyroscope Jerk SD -X"                       | Average of Field by Subject And Activity|
| "Time Body Gyroscope Jerk SD -Y"                       | Average of Field by Subject And Activity|
| "Time Body Gyroscope Jerk SD -Z"                       | Average of Field by Subject And Activity|
| "Time Body Accelerometer Magnitude Mean "              | Average of Field by Subject And Activity|
| "Time Body Accelerometer Magnitude SD "                | Average of Field by Subject And Activity|
| "Time Gravity Accelerometer Magnitude Mean "           | Average of Field by Subject And Activity|
| "Time Gravity Accelerometer Magnitude SD "             | Average of Field by Subject And Activity|
| "Time Body Accelerometer Jerk Magnitude Mean "         | Average of Field by Subject And Activity|
| "Time Body Accelerometer Jerk Magnitude SD "           | Average of Field by Subject And Activity|
| "Time Body Gyroscope Magnitude Mean "                  | Average of Field by Subject And Activity|
| "Time Body Gyroscope Magnitude SD "                    | Average of Field by Subject And Activity|
| "Time Body Gyroscope Jerk Magnitude Mean "             | Average of Field by Subject And Activity|
| "Time Body Gyroscope Jerk Magnitude SD "               | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Mean -X"                 | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Mean -Y"                 | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Mean -Z"                 | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer SD -X"                   | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer SD -Y"                   | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer SD -Z"                   | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Jerk Mean -X"            | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Jerk Mean -Y"            | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Jerk Mean -Z"            | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Jerk SD -X"              | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Jerk SD -Y"              | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Jerk SD -Z"              | Average of Field by Subject And Activity|
| "Frequency Body Gyroscope Mean -X"                     | Average of Field by Subject And Activity|
| "Frequency Body Gyroscope Mean -Y"                     | Average of Field by Subject And Activity|
| "Frequency Body Gyroscope Mean -Z"                     | Average of Field by Subject And Activity|
| "Frequency Body Gyroscope SD -X"                       | Average of Field by Subject And Activity|
| "Frequency Body Gyroscope SD -Y"                       | Average of Field by Subject And Activity|
| "Frequency Body Gyroscope SD -Z"                       | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Magnitude Mean "         | Average of Field by Subject And Activity|
| "Frequency Body Accelerometer Magnitude SD "           | Average of Field by Subject And Activity|
| "Frequency BodyBody Accelerometer Jerk Magnitude Mean "| Average of Field by Subject And Activity|
| "Frequency BodyBody Accelerometer Jerk Magnitude SD "  | Average of Field by Subject And Activity|
| "Frequency BodyBody Gyroscope Magnitude Mean "         | Average of Field by Subject And Activity|
| "Frequency BodyBody Gyroscope Magnitude SD "           | Average of Field by Subject And Activity|
| "Frequency BodyBody Gyroscope Jerk Magnitude Mean "    | Average of Field by Subject And Activity|
| "Frequency BodyBody Gyroscope Jerk Magnitude SD "      | Average of Field by Subject And Activity|
