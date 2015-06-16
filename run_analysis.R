library(dplyr)

##Reading of Data
subjet_test <- read.table("subject_test.txt")
subjet_train <- read.table("subject_train.txt")
X_test <- read.table("X_test.txt")
X_train <- read.table("X_train.txt")
y_test <- read.table("y-test.txt")
y_train <- read.table("y-train.txt")
features <- read.table("features.txt")

##Making sure the labels are correct
labels <- features$V2
colnames(subject_test) <- c("subject")
colnames(subject_train) <- c("subject")
colnames(y_test) <- c("activity")
colnames(y_train) <- c("activity")
colnames(X_test) <- labels
colnames(X_train) <- labels

##Combine data into one
test <- cbind(subject_test, X_test, y_test)
train <- cbind(subject_train, X_train, y_train)
data <- rbind (test, train)

##Tidy up the dataset
selected <- data[, grepl("std()", colnames(data)) | 
                         grepl("mean()", colnames(data)) ]
activity <- data$activity
subject <- data$subject
tidy <- cbind(activity, subject, selected)

## Making activities real names
tidy$activity_name[tidy$activity == 1] <- "WALKING"
tidy$activity_name[tidy$activity == 2] <- "WALKING_UPSTAIRS"
tidy$activity_name[tidy$activity == 3] <- "WALKING_DOWNSTAIRS"
tidy$activity_name[tidy$activity == 4] <- "SITTING"
tidy$activity_name[tidy$activity == 5] <- "STANDING"
tidy$activity_name[tidy$activity == 6] <- "LAYING"
tidy <- tidy[,c(ncol(tidy),1:(ncol(tidy)-1))]

##Creating and outputing the new data
NewData<-aggregate(. ~subject + activity_name, tidy, mean)
write.table(NewData, output.txt, row.name=FALSE) 