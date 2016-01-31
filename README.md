# README - Getting and Cleaning Data project
The run_analysis.R script will write the tidy dataset as described on Coursera. it contains 2 functions:
  - composeDataSet
  - run_analysis

The **composeDataSet** procedure builds a dataframe by collecting the data in a folder indicated by the parameter directory. The 2nd parameter features is used to determine the column names for the measurements (since the data files themselves contain no column names). it reads the files to get the labels(y), subjects and measurements. for each part of the dataset the names are configured and they are merged to 1 dataset by using a help-column observation_ID (that is removed afterward).

The **run_analysis** procedure uses the procedure above to collect the needed data from the train & test folders and combines them in 1 dataset. the actvity code is translated into the activity name by merging with the data read from the activity_labels file, all but the mean and std + subject ID and activity are ignored. Per subject and activity the average of the data is being calculated. this is stored in a file called "tidydataset.txt". the dataset from step 1 will be stored in a variable called tidydataset.

As a last step of the script the run_analysis function is called so that the file with the averages per subject per activity is written and the dataset is from the previous steps is stored in the 
