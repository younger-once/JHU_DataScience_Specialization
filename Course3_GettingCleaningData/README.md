# Getting and Cleaning Data Project

## Overview  
This repo contains an R script that downloads, wrangles, and summarizes wearable sensor data.  The script outputs a text file in tidy data format.  
 
## Raw Data    

The data set is based on sensor signals extracted from Samsung Galaxy S II smartphones worn by 30 subjects at waist level.  Subjects were recorded while performing various functions such as standing, sitting, or walking.  
 
 A full description of the data set can be found [here](http://archive.ics.uci.edu/ml/datasets/[Human+Activity+Recognition+Using+Smartphones).
  
Raw data files used in this analysis were downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  
  
## Repo Files 
This repo contains the following primary data files:  
  
* `run_analysis.r` - R script to process raw data and output tidy dataset. 
* `tidy_summary_data.csv` - file output (in tidy format)
*  `codebook.md` - data dictionary with additional details on data transformations

## Data Processing Steps

The `run_analysis.r` script performs the following tasks:  
  
 1. Downloads and unzips original data files
 2. Reads activity labels file
 3. Reads and processes feature names file
 	-  Retains features with mean and standard deviation measurements (i.e. features with terms "mean()" or "std()")
 	-  Modifies feature names to improve readability
 4. Reads and processes training data
	- Assigns column names based on modified feature descriptions
	- Joins in activity descriptions from activity label file
	- Reads in training subject identifier file and combines with training data
5. Reads and processes test data (with substeps similar to #4)
6. Combines training and test data sets
7. Transforms data to long format
8. Breaks out feature names into individual components
9. Creates a new data frame that summarizes average measurements for each of the following combinations:
	- subject
	- activity
	- feature combinations
	- measurement type (mean or standard deviation)
- Outputs summary data frame as txt file, `tidy_summary_data.csv`

## Tidy Data Commentary
According to [R for Data Science](https://r4ds.had.co.nz/tidy-data.html), tidy data is defined as follows: 

-  Each variable is assigned to a unique column
-  Every observation is organized into a single row
-  Each value is organized in its own cell

Satisfying any two of these rules implies that the remaining rule is also met. 
 
For this assignment, each of the original feature names was interepreted to represent a composite description of multiple variables.  To get the data in tidy format, the feature names were first separated into individual columns to represent unique component variables--see the code book for details:  

- dimension
- signal
- instrument
- jerk
- measureType
- directionMag   

The variable `measureType` has two distinct values:  "mean" and "std". These values were interpreted as describing two separate measure variables.  Therefore, the data set was transposed wide to produce two unique measure variable columns for the mean and standard deviation variables, respectively.        

Each row of the summary data set contains average mean and standard deviation measurements for each subject, activity, and combination of feature variables.  This grouping is consistent with the observational units suggested by the assignment instructions: create a "tidy data set with the average of each variable for each activity and each subject".

 	 
 
  

 
 


 

