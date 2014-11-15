We begin with 6 raw raw files from the UCI HAR Dataset, X_test.txt, X_train.txt, y_test.txt, y_train.txt, features.txt, and activity_labels.txt.

After loading in files, we combine both the X_test.txt and X_train.txt files into the X_all data frame using the rbind command. Similarly, we combine the y_test.txt and y_train.txt files into the y_all data frame.

Next, we load in the features.txt and activity_labels.txt files from the UCI HAR Dataset. We add the features labeels from features.txt as headers to the X_all dataframe using the names command.

To extract only the features representing the mean and standard deviation of the variables, we make note of the fact that these all are formated similarly, either containing the text mean() or std() in the name. We use regular expression matching to extract only these variables, using the grep command. We then subset the X_all data frame to only contain these columns, storing the result in a new data frame, X_all_relevant.

Next, we work to add the activity names to our data set. We start by prepending the y_all data frame to the X_all_relevant data frame using the cbind function, storing the result in a new data frame, X_all_labeled. This adds a column with integer values ranging from 1-6. Next, we need to replace these integer values with their corresponding activity names. We do this by using the merge function, merging the X_all_labeled data frame with the activity_labels.txt file from above, where the common field is the integer values representing the activities. The result is stored in a new data frame, mergedData.

Now, we have a tidy data set that contains column labels corresponding only to mean and standard deviation of features and row labels corresponding to the associated activity. We can now easily use this tidy data set for analysis.

We use the aggregate function to apply the mean operation to all columns of our tidy data set, separately applying this function to each of the 6 activities. This results in an output that is 66 columns (corresponding to the 33 mean and 33 standard deviation features), and 6 rows (corresponding to the 6 activities). Each data point tells us the mean value of the corresponding feature (column name) across all observations of the specified activity (row name) in the data set.

We use the write.table function to write this output to a file called tidy.txt for submission.

Individual Column Name Descriptions as Below:

 [1] "Activity"                                             
  [2] "Subject"                                              
   [3] "Time Body Accelerometer Mean -X"                      
    [4] "Time Body Accelerometer Mean -Y"                      
     [5] "Time Body Accelerometer Mean -Z"                      
      [6] "Time Body Accelerometer SD -X"                        
       [7] "Time Body Accelerometer SD -Y"                        
        [8] "Time Body Accelerometer SD -Z"                        
         [9] "Time Gravity Accelerometer Mean -X"                   
         [10] "Time Gravity Accelerometer Mean -Y"                   
         [11] "Time Gravity Accelerometer Mean -Z"                   
         [12] "Time Gravity Accelerometer SD -X"                     
         [13] "Time Gravity Accelerometer SD -Y"                     
         [14] "Time Gravity Accelerometer SD -Z"                     
         [15] "Time Body Accelerometer Jerk Mean -X"                 
         [16] "Time Body Accelerometer Jerk Mean -Y"                 
         [17] "Time Body Accelerometer Jerk Mean -Z"                 
         [18] "Time Body Accelerometer Jerk SD -X"                   
         [19] "Time Body Accelerometer Jerk SD -Y"                   
         [20] "Time Body Accelerometer Jerk SD -Z"                   
         [21] "Time Body Gyroscope Mean -X"                          
         [22] "Time Body Gyroscope Mean -Y"                          
         [23] "Time Body Gyroscope Mean -Z"                          
         [24] "Time Body Gyroscope SD -X"                            
         [25] "Time Body Gyroscope SD -Y"                            
         [26] "Time Body Gyroscope SD -Z"                            
         [27] "Time Body Gyroscope Jerk Mean -X"                     
         [28] "Time Body Gyroscope Jerk Mean -Y"                     
         [29] "Time Body Gyroscope Jerk Mean -Z"                     
         [30] "Time Body Gyroscope Jerk SD -X"                       
         [31] "Time Body Gyroscope Jerk SD -Y"                       
         [32] "Time Body Gyroscope Jerk SD -Z"                       
         [33] "Time Body Accelerometer Magnitude Mean "              
         [34] "Time Body Accelerometer Magnitude SD "                
         [35] "Time Gravity Accelerometer Magnitude Mean "           
         [36] "Time Gravity Accelerometer Magnitude SD "             
         [37] "Time Body Accelerometer Jerk Magnitude Mean "         
         [38] "Time Body Accelerometer Jerk Magnitude SD "           
         [39] "Time Body Gyroscope Magnitude Mean "                  
         [40] "Time Body Gyroscope Magnitude SD "                    
         [41] "Time Body Gyroscope Jerk Magnitude Mean "             
         [42] "Time Body Gyroscope Jerk Magnitude SD "               
         [43] "Frequency Body Accelerometer Mean -X"                 
         [44] "Frequency Body Accelerometer Mean -Y"                 
         [45] "Frequency Body Accelerometer Mean -Z"                 
         [46] "Frequency Body Accelerometer SD -X"                   
         [47] "Frequency Body Accelerometer SD -Y"                   
         [48] "Frequency Body Accelerometer SD -Z"                   
         [49] "Frequency Body Accelerometer Jerk Mean -X"            
         [50] "Frequency Body Accelerometer Jerk Mean -Y"            
         [51] "Frequency Body Accelerometer Jerk Mean -Z"            
         [52] "Frequency Body Accelerometer Jerk SD -X"              
         [53] "Frequency Body Accelerometer Jerk SD -Y"              
         [54] "Frequency Body Accelerometer Jerk SD -Z"              
         [55] "Frequency Body Gyroscope Mean -X"                     
         [56] "Frequency Body Gyroscope Mean -Y"                     
         [57] "Frequency Body Gyroscope Mean -Z"                     
         [58] "Frequency Body Gyroscope SD -X"                       
         [59] "Frequency Body Gyroscope SD -Y"                       
         [60] "Frequency Body Gyroscope SD -Z"                       
         [61] "Frequency Body Accelerometer Magnitude Mean "         
         [62] "Frequency Body Accelerometer Magnitude SD "           
         [63] "Frequency BodyBody Accelerometer Jerk Magnitude Mean "
         [64] "Frequency BodyBody Accelerometer Jerk Magnitude SD "  
         [65] "Frequency BodyBody Gyroscope Magnitude Mean "         
         [66] "Frequency BodyBody Gyroscope Magnitude SD "           
         [67] "Frequency BodyBody Gyroscope Jerk Magnitude Mean "    
         [68] "Frequency BodyBody Gyroscope Jerk Magnitude SD "
