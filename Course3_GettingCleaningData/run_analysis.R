# load relevant libraries
library(dplyr)
library(tidyr)

# download and unzip files
myurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(myurl, "Dataset.zip"); unzip("Dataset.zip")

# update working directory
setwd("./UCI HAR Dataset")

# read in activity label numbers and descriptions
activity_labels <- read.table('activity_labels.txt',col.names=c("activityNum","activityDesc"))

# read in feature names
X_feature_names <- read.table('features.txt', col.names=c('featureNum','featureName'))

# limit feature names to include "mean()" and "std()" only 
# -- note: assuming "meanFreq()" and any other columns with "Mean" are not required for analysis
# -- make feature names more readable (e.g. replace "t" with "Time", "f" with "Freq")
X_feature_names <- X_feature_names[grep("mean\\(\\)|std\\(\\)",X_feature_names$featureName),] %>% 
  mutate(featureName = sub("(?=Body|Gravity)","-",featureName, perl=T),
         featureName = sub("(?=Acc|Gyro)","-",featureName,perl=T), 
         featureName = ifelse(grepl("Mag",featureName),
                              sub("\\(\\)","-Mag",featureName),featureName),
         featureName = ifelse(grepl("Jerk",featureName),
                              sub("Jerk","-Y",featureName),sub("(?<=Acc|Gyro)","-N",featureName, perl=T)),
         featureName = sub("Mag","",featureName),
         featureName = gsub("^t", "Time",featureName),
         featureName = gsub("^f","Freq",featureName),
         featureName = gsub("\\(\\)","",featureName)
         )
         
# read training features data - limited to mean() and std() columns
X_train <- read.table("train/X_train.txt")[, X_feature_names$featureNum]
names(X_train) <- X_feature_names$featureName

# read training activities data - using join to bring in activity descriptions 
y_train <- read.table("train/y_train.txt", col.names="activityNum") %>% 
  inner_join(activity_labels, by="activityNum")

# read in training data subject number
subject_train <- read.table("train/subject_train.txt",col.names="subject")

# create training data set by combining multiple variables
train <- cbind("dataset"="train",subject_train,"activity"=y_train$activityDesc,X_train)

# read test features data - limited to mean() and std() columns
X_test <- read.table("test/X_test.txt")[, X_feature_names$featureNum]
names(X_test) <- X_feature_names$featureName

# read test activities data - using join to bring in  activity descriptions 
y_test <- read.table("test/y_test.txt", col.names="activityNum") %>% 
  inner_join(activity_labels, by="activityNum")
  
# read in test data subject number
subject_test <- read.table("test/subject_test.txt",col.names="subject")

# create training data set by combining multiple variables
test <- cbind("dataset"="test",subject_test,"activity"=y_test$activityDesc,X_test)

# combine training and test data sets together into one data frame
df <- rbind(train,test)

# create long data frame; create separate variables for each feature component
df <- df %>% gather("var","val",-dataset,-subject,-activity) %>%
  separate(var,into=c("domain","signal","instrument","jerk","measureType","directionMag"))

# create independent data frame that summarizes average measurement value for each 
# -- subject, activity, feature combination, and measurement type
# -- make data set "wider" by including both mean and standard deviation for each subject, activity,
# -- and feature combination
df_summary <- df %>% group_by(subject,activity,domain,signal,instrument,jerk,measureType,directionMag) %>%
  summarise(meanVal=mean(val)) %>% spread(measureType,meanVal)

# save summary data frame as text file
write.table(df_summary,"../tidy_summary_data.txt",row.names = F)


