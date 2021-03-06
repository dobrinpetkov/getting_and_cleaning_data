#Getting and Cleaning Data - Course Project

### Basic structure of run_analysis.R

The script assumes that there is folder **datasets** with the Samsung data in the working directory. Afterwards, the script follows the assignment requirements.

1. Read train and test datasets - the following datasets are read:
	* activity_labels.txt
	* features.txt
	* test/subject_test.txt
	* test/X_test.txt
	* test/y_test.txt
	* train/subject_train.txt
	* train/X_train.txt
	* train/y_train.txt

The datasets in **test/Inertial Signals/** and **train/Inertial Signals/** are not read as we do not need them for the analysis.

2. Steps 2 - extracting measurements on the mean and standard deviation, merging the test and train datasets and naming the variables with more descriptive names. 
Here I have assumed that by measurements on the mean and standard deviation for each measurement it is meant columns that contain one of the strigns **mean()** or **std()**. 
For example, that implies that *fBodyAcc-mean()-X* is included and *fBodyAcc-meanFreq()-X* is not as the latter is *weighted* average of the frequency components.
Merging is done via rbind() because it is simple and it does not reorder the rows.

3. Step 3, which is adding descriptive activity names to name the activities in the dataset, is done next.

4. The last step is creating new tidy data set with the average of each variable for each activity and each subject, and saving that data set in output.txt.

 