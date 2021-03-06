## The code does the following:
## 1. Read train and test data sets 
## 2. Merges train and test data sets
## 3. Fetches columns with observation on the mean and the standard deviation
## 4. Changes variable names with more descriptive
## 5. Set descriptive activity names
## 6. Creates new, tidy data set  with the average of each variable for each activity and each subject and saves it to output.txt


#------------------------------------STEP 1: READ DATASETS---------------------------------------------------
setwd("datasets")
act_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")


# read test datasets
setwd("test")
subject_test <- read.table("subject_test.txt") # subject id
x_test <- read.table("X_test.txt") # measurements on variables
y_test <- read.table("y_test.txt") # activity id
setwd("..") # test

# read train datasets
setwd("train")
subject_train <- read.table("subject_train.txt")
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
setwd("..") # train

setwd("..") # datasets


#------------------------------------STEP 2 AND STEP 4: EXTRACT MEASUREMENTS ON THE MEAN AND STD----------------------------
#---------------------------AND LABEL DATASET WITH MORE DESCRIPTIVE VARIABLES NAMES ----------------------------------------
require(dplyr)

# indexes of the columns which contain observations on the mean and on the standard deviation
col_idx <- which(grepl("mean()", features[, 2], fixed = TRUE) | grepl("std()", features[, 2], fixed = TRUE)) 

# --------- Merge the train and test datasets 
m <- rbind(select(x_train, col_idx), select(x_test, col_idx)) # merge x observations

# extract column names and changed them with more descriptive
col_names <- features[col_idx, 2]

col_names <- gsub("-", "_", col_names)
col_names <- gsub("mean()", "mean", col_names, fixed = TRUE)
col_names <- gsub("std()", "std", col_names, fixed = TRUE)
col_names <- gsub("Acc", "Acceleration", col_names, fixed = TRUE)
col_names <- gsub("Mag", "Magnitude", col_names, fixed = TRUE)
col_names <- gsub("tB", "time_B", col_names, fixed = TRUE)
col_names <- gsub("fB", "freq_B", col_names, fixed = TRUE)
col_names <- gsub("tG", "time_G", col_names, fixed = TRUE)
col_names <- gsub("fG", "freq_G", col_names, fixed = TRUE)
col_names <- gsub("BodyBody", "Body", col_names, fixed = TRUE)

names(m) <- col_names

m$subject_id <- c(subject_train$V1, subject_test$V1) # add subject id
m$activity <- c(y_train$V1, y_test$V1) # sdd activity

#-----------------------STEP 3: ADD DESCRIPTIVE ACTIVITY NAMES------------------------------------------------
m$activity <- act_labels[m$activity,2] # set descriptive names for the activities



#--------------------------------MAKE NEW TIDY DATA SET WITH THE AVERAGE FOR EACH VARIABLE---------------------------
#---------------------------FOR EACH ACTIVITY AND EACH SUBJECTS------------------------------------------------------
# summarize data and write the output file
sm <- m %>% group_by(subject_id, activity) %>% summarise_each(funs(mean)) # mean for each group of (subject_id) x (activity)
write.table(sm, file = "output.txt", row.name = FALSE)

