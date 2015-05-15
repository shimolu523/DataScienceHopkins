# This code produces a clean data set obtained from the following source
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Getting data:
url_dataSource <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(url_dataSource, destfile = "data_folder.zip")
fileNames <- unzip("data_folder.zip")

# Merging data:
# According to the data description, the testing and traning sets are 
# test: X_test.txt, which is fileNames[15] 
# train: X_train.txt, which is fileNames[27]

# For the same row of the test/train sets,
# the activity names are labelled in file y_test.txt and y_train.txt, respectively
# the subject names are labelled in file subject_test.txt, and subject_train.txt

# We first add the activity and subject labels to the data sets
data_test <- cbind(read.table(fileNames[14]),read.table(fileNames[16]),read.table(fileNames[15]))
data_train <- cbind(read.table(fileNames[26]),read.table(fileNames[28]),read.table(fileNames[27]))
names(data_test)[1] <- "sub"; names(data_train)[1] <- "sub"
names(data_test)[2] <- "act"; names(data_train)[2] <- "act"

# Now merge the data
data <- merge(data_test, data_train, all = TRUE)

# Now for each activity labelled by the first column in data, find mean and stdev
subs <- unique(data$sub); 
acts <- unique(data$act)

mns <- NULL; stdev <- NULL;
for (sub in subs){
    for (act in acts){
        mns <- rbind(mns, apply(data[data$sub == sub & data$act == act,3:563], 2, mean))
        stdev <- rbind(stdev, apply(data[data$sub == sub & data$act == act,3:563], 2, sd))
    }
}

# Now replace the labels with activity names:
# The activity name is in the file activity_labels.txt
actName <- read.table(fileNames[1])$V2
# relabelling the activities in data$act
data$act <- as.factor(data$act)
levels(data$act) <- actName

# Now label the measurement, the name of which is in features.txt
measName <- read.table(fileNames[2])$V2
names(data)[3:563] <- as.character(measName)

# Now create a new data set with mean values of each measurement for each subject for each activity
data_tidy <- data.frame(cbind(rep(subs, each = 6), rep(acts, 30), mns))
names(data_tidy) <- c("sub", "act", as.character(measName))
data_tidy$act <- as.factor(data_tidy$act)
levels(data_tidy$act) <- actName

# Export data to UCIHARtidyData.txt
write.table(data_tidy, file = "UCIHARtidyData.txt")