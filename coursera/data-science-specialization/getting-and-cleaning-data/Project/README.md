# Getting and Cleaning Data Course Project

The run_analysis.R script reads in 8 files from the UCI HAR Dataset, *X_test.txt*,
*X_train.txt*, *y_test.txt*, *y_train.txt*, *subject_test*, *subject_train*, 
*features.txt*, and *activity_labels.txt*. The script then combines the test 
and training data sets, pulls values associated with the mean and standard
deviation of the variables, and combines the data in a single data set.  It then
adds data related to each activity and subject, determining the mean value of
each variable by activity and subject.  Finally, the script replaces the header
names with more descriptive variable names for clarity.  

If the UCI HAR Dataset is downloaded as-is and placed within a subdirectory 
where the run_analysis.R script is located, you can simply run run_analysis.R 
to perform all necessary transformations and create the output file *tidy.txt*.  

Additional detail about the transformations that occur as a part of the script
can be found within the CodeBook.md file.

