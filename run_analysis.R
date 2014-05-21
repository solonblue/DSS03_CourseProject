### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Section 1 Loading data files into R
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Read various data into R
features = read.table("features.txt")
activity = read.table("activity_labels.txt")
subjectTrain = read.table("train/subject_train.txt")
xTrain = read.table("train/X_train.txt")
yTrain = read.table("train/Y_train.txt")
subjectTest = read.table("test/subject_test.txt")
xTest = read.table("test/X_test.txt")
yTest = read.table("test/Y_test.txt")

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Section 2 Add variable names and combine train/test set
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# rename subjectTrain and subjectTest to subjectid 
names(subjectTrain) = "subjectid"
names(subjectTest) = "subjectid"

# change names of features (features$V2) to lower case
names(xTrain) = tolower(features$V2)
names(xTest) = tolower(features$V2)

# combine subject, y, x to have complele train/test set
allTrain = cbind(subjectTrain, yTrain, xTrain)
allTest = cbind(subjectTest, yTest, xTest)

# combine train and test set into one data set(allData)
allData = rbind(allTrain, allTest)

# merge complete set (allData) with activity
allData = merge(allData, activity, by.x = 'V1', by.y = 'V1')

#Re-arrange activity column to be the first column and delete activity code (1 - 6)
allData$V1 = allData$V2
names(allData)[1] = "activity"
allData$V2 = NULL

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Section 3 filter out data related to mean and std of measurements
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# filter out columns whose names contain mean(), std(), subjectid and activity and subset
# into small data frame(data)
gotMean = grepl(paste("mean", "\\()", sep = ""), names(allData))
gotStd = grepl(paste("std", "\\()", sep = ""), names(allData))
gotSubject = grepl("subjectid", names(allData))
gotAct = grepl("activity", names(allData))
combined = gotMean | gotStd | gotSubject | gotAct
data = allData[,combined]

# remove illegal characters in variable names, including -, (, ), and ,
names(data) = gsub("-", "", names(data))
names(data) = gsub("\\(", "", names(data))
names(data) = gsub(")", "", names(data))


### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### Section 4 create second data set of meansures group by activity and suject
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# aggregate by first two columns (activity and subjectid) to have
# a new data frame dataByActSub
dataByActSub = aggregate(data[,3:68], data[,1:2], FUN = sum)

### ~~~~~~~~~~~~~~~~~~~~~~
### Section 5 Export data
### ~~~~~~~~~~~~~~~~~~~~~~
write.table(data, file = "data.txt")
write.table(dataByActSub, file = "dataByActSub.txt")


