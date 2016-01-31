run_analysis <- function(){
  #get the labels so that the activity code can be translated in the activity name
  activity_labels <- read.table("activity_labels.txt")
  names(activity_labels) <- c("activity_code", "activity_name")
  
  #get the features so that the measurement values can be linked to a measurement name
  # --> knowing what is being measured
  features <- read.table("features.txt")
  names(features) <- c("feature_code", "feature_name")
  
  #compose a dataset using the test folder
  test <- composeDataSet("test", features)
  #compose a dataset using the train folder
  train <- composeDataSet("train", features)
  
  #merge the 2
  merged <- rbind(train, test)
  #step 1 reached
  
  #decode activity
  merged <- merge(x=merged, y=activity_labels, by.x="activity_code", by.y="activity_code")
  #remove the first column, it got added because of the merge
  merged <- merged[,-1]
  # step 3 reached 

  #we are only interrested in the mean and standard deviations
  #leave out the rest of the measurements, but keep the first (subject_ID) and last (activity_name)
  # I wasn't really sure if it's ok to keep it in, but it's needed for the eventual dataset...
  tidydataset <- merged[,c(grep("(-mean\\(\\)|-std\\(\\))",colnames(merged)), 1, ncol(merged))]
  #step 2 reached
  #write.table(tidydataset, file="tidydataset.txt", row.names=FALSE)
  
  # calculate the average of the measurements per subject per activity
  collapsedtidyset <-aggregate(tidydataset, by=list(tidydataset$subject_ID,tidydataset$activity_name), FUN=mean, na.rm=TRUE)
  #remove the 2 last columns, they are added again on the left due to aggregating 
  collapsedtidyset <- collapsedtidyset[,1:(ncol(collapsedtidyset)-2)]
  names(collapsedtidyset)[1:2] <- c("subject_ID", "activity")
  
  #write the tidy dataset to a file
  write.table(collapsedtidyset, file="tidydataset.txt", row.names=FALSE)
  tidydataset
}


#function to help compose the dataframe
#since train folder & test folder have similar structure
composeDataSet <- function(directory, features){
  #get the labels
  labels <- read.table(file.path(directory, paste("y_", tolower(directory), ".txt", sep="")))
  names(labels) <- c("activity_code")
  # add an observation id so that everything can be merged
  labels$observation_ID <- 1:nrow(labels)
  
  #get the testsubjects
  subjects <- read.table(file.path(directory, paste("subject_", tolower(directory), ".txt", sep="")))
  names(subjects) <- c("subject_ID")
  # add an observation id so that everything can be merged
  subjects$observation_ID <- 1:nrow(subjects)
  
  #get the measurements
  measurements <- read.table(file.path(directory, paste("X_", tolower(directory), ".txt", sep="")))
  names(measurements) <- features$feature_name
  # add an observation id so that everything can be merged
  measurements$observation_ID <- 1:nrow(measurements)
  
  #merge the data of the corresponding directory in 1 dataframe
  merged <- merge(x=subjects, y=measurements, by.x="observation_ID", by.y="observation_ID")
  merged <- merge(x=merged, y=labels, by.x="observation_ID", by.y="observation_ID")
  #get rid of the observation ID, they were only added to make the merge easier
  merged$observation_ID <- NULL
  
  #return the dataset of 1 folder (indicated by parameter)
  merged
}


tidydataset <- run_analysis()




