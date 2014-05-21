## This is for Coursera Data Science Specification/Getting and Clearning Data/Course project

* The objetive is to have a tidy data by combination, renaming, filtering and aggregation in R.

* **A quick summary of R code. Details please refer to the run_analysis.R**

	Section 1 Loading data files into R
	Section 2 Add variable names and combine train/test set
	Section 3 filter out data related to mean and std of measurements
	Section 4 create second data set of meansures group by activity and suject
	Section 5 Export data

* Logic of renaming

	1. 561 variables are in X_train.txt and X_test.txt, names of 561 variables are in features.txt
	2. activity codes are in Y_train.txt and Y_test.txt, names of activiti codes are in activity_lable.txt

* Logic of combination
	
	1. subject_train, Y_train and X_train have the same numbers of rows, which means same observation for each
	row. THerefore they can be combined with cbind.It also works similarly to test set.
	2. The combined train set and test set have same numbers of columns, which means the two data sets are just
	for different observations. Therefore, they can be combined with rbind.

*  Logic of filtering mean and std related data

	1. use grepl for text search in all column names
	2. use paste("mean", "\\()", sep = "") to special distinguish "mean" and "mean()"

* Logic of creating creating second data set of meansures group by activity and suject

	1. Simply utilize aggregate function 
	
	