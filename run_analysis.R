# Load required libraries
library(dplyr)

# Download and unzip dataset if it doesn't exist
if (!file.exists("UCI HAR Dataset")) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, destfile = "dataset.zip", method = "auto")
  unzip("dataset.zip")
}

# Load activity labels and features
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"), stringsAsFactors = FALSE)
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "feature"), stringsAsFactors = FALSE)

# Extract only mean and standard deviation features
selected_features <- grep("-(mean|std)\\(\\)", features$feature)
selected_feature_names <- features[selected_features, 2]

# Load training data
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")[, selected_features]
train_y <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train <- cbind(train_subject, train_y, train_x)

# Load test data
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")[, selected_features]
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test <- cbind(test_subject, test_y, test_x)

# Merge training and test sets
data <- rbind(train, test)

# Assign descriptive column names
colnames(data) <- c("subject", "activity", selected_feature_names)
colnames(data) <- gsub("[-()]", "", colnames(data))

# Ensure activity_labels is properly loaded and used
data$activity <- factor(data$activity, levels = activity_labels$id, labels = activity_labels$activity)

# Create a second tidy data set with the average of each variable for each activity and each subject
tidy_data <- data %>% 
  group_by(subject, activity) %>% 
  summarise(across(everything(), mean))

# Write the tidy dataset to a file
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)

