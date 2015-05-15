The code run_analysis.R produces a clean data set obtained from the following source:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

As long as the url is valid, running the code in R will produce a txt file named "UCIHARtidyData" in the current work directory.

The data has 180 rows and 563 columns.
column 1 - subject number: there're 30 subjects who volunteered the study, numbered 1-30
column 2 - activity: there're 6 activities, which are self-explanatory from the column entries
column 3-563 - measurement: the mean of measurements conducted. The type of measurement is indicated by the column names.