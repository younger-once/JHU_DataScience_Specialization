# Codebook - Sensor Summary Data

## Background 
  
From the original data codebook: 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. 

## Data Modifications
The original dataset features were composites of multiple underlying component variables.  With the goal of creating a tidy dataset with one variable per column, the original features were partitioned into six separate variables:  
 
* domain
* signal
* instrument
* jerk
* directionMag 
* measureType

The measureType variable produces two distinct values: "mean" and "std". These values were interpreted as describing two separate measure variables. Therefore, the data set was transposed wide to produce two measure variable columns to represent the mean and standard deviation variables, respectively.


## Data Dictionary 
* **subject** (integer) - Identification variable used to represents the individual being observed. Valid values are 1 through 30.
* **activity** (character) - Description of the physical activity performed by the subject under observation.  Valid values are: 
	* LAYING
	* SITTING
	* STANDING
	* WALKING
	* WALKING_DOWNSTAIRS
	* WALKING_UPSTAIRS 
* **domain** (character) - Indicates whether the sensor signal is in the time or frequency domain.  Valid values are:
	* Time
	* Freq
* **signal** (character) - characterizes the sensor signal type:
	* Body
	* BodyBody 
	* Gravity
* **instrument** (character) - device used to capture signal.  Instrument types are accelerometer and gyroscope, represented by the following abbreviations:
	* Acc 
	* Gyro
* **jerk** (character) - indicator variable to distinguish "jerk" signals.  Valid values are:
	* Y
	* N
* **directionMag** (character) - Provides the direction of the sensor signal (i.e. X, Y, or Z) or indicates that the magnitude  of the signal (using the Euclidean norm) is being calculated.  Valid values are:
	* X
	* Y
	* Z
	* Mag
* **mean** (double) - the average mean signal measurement for the given subject, activity, and feature combination.  
 
* **std** (double) - the average standard deviation measurement for the given subject, activity, and feature combination.
	
    
	 
