# Q1: Load the vowel.train and vowel.test data sets:

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

# Set the variable y to be a factor variable in both the training and test set. 
# Then set the seed to 33833. Fit 
# (1) a random forest predictor relating the factor variable y to the remaining variables and 
# (2) a boosted predictor using the "gbm" method. Fit these both with the train() command in the caret package. 
# What are the accuracies for the two approaches on the test data set? 
# What is the accuracy among the test set samples where the two methods agree?

set.seed(33833)
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

modelFit_nb <- train(y ~., method = "rf", data = vowel.train) # no boosting
nbResult <- predict(modelFit_nb, vowel.test[,2:11])
confusionMatrix(vowel.test$y, nbResult)

modelFit_b <- train(y ~., method = "gbm", data = vowel.train, verbose = FALSE) # with boosting
bResult <- predict(modelFit_b, vowel.test[,2:11])
confusionMatrix(vowel.test$y, bResult)

agrInd <- nbResult == bResult
confusionMatrix(vowel.test$y[agrInd], bResult[agrInd])

# Q2: Load the Alzheimer's data using the following commands

library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Set the seed to 62433 and predict diagnosis with all the other variables using a random forest ("rf"), boosted trees ("gbm") and linear discriminant analysis ("lda") model. 
# Stack the predictions together using random forests ("rf"). 
# What is the resulting accuracy on the test set? 
# Is it better or worse than each of the individual predictions?

set.seed(62433)

# 3 different models and corresponding predictions
model_rf <- train(diagnosis ~., method ="rf", data = training)
model_gbm <- train(diagnosis ~., method = "gbm",data = training)
model_lda <- train(diagnosis ~., method = "lda",data = training)

pred_rf <- predict(model_rf, testing[2:131])
pred_gbm <- predict(model_gbm, testing[2:131], verbose=FALSE)
pred_lda <- predict(model_lda, testing[2:131])

# combined model:
predDF <- data.frame(pred_rf, pred_gbm, pred_lda, diagnosis = testing$diagnosis)
model_comb <- train(diagnosis ~ ., method = "rf", data = predDF)
pred_comb <- predict(model_comb, predDF)

# accuracy of combined and individual models:
accu_comb <- sum(pred_comb == predDF$diagnosis)/length(predDF$diagnosis)

accu_rf <- sum(pred_rf == predDF$diagnosis)/length(predDF$diagnosis)
accu_gbm <- sum(pred_gbm == predDF$diagnosis)/length(predDF$diagnosis)
accu_lda <- sum(pred_lda == predDF$diagnosis)/length(predDF$diagnosis)

# Load the concrete data with the commands:
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Set the seed to 233 and fit a lasso model to predict Compressive Strength. 
# Which variable is the last coefficient to be set to zero as the penalty increases? 
# (Hint: it may be useful to look up ?plot.enet).

set.seed(233)
modelFit <- train(CompressiveStrength ~., method = "lasso", data = training)
plot.enet(modelFit$finalModel, xvar = "penalty", use.color = TRUE)

# Q4: Load the data on the number of visitors to the instructors blog from here: 
# https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv

url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"
download.file(url, destfile = "gaData.csv")

# Using the commands:

library(lubridate)  # For year() function below
dat = read.csv("gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

# Fit a model using the bats() function in the forecast package to the training time series. 
# Then forecast this model for the remaining time points. 
# For how many of the testing points is the true value within the 95% prediction interval bounds?

library(forecast)
modelFit <- bats(tstrain)
fcast <- forecast(modelFit, level = 95, h=length(testing$visitsTumblr))
percentage<- sum(testing$visitsTumblr < fcast$upper & testing$visitsTumblr > fcast$lower)/length(fcast$lower)


# Q5: Load the concrete data with the commands:
set.seed(3523)
library(caret)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Set the seed to 325 and 
# fit a support vector machine using the e1071 package to predict Compressive Strength using the default settings. 
# Predict on the testing set. What is the RMSE?

set.seed(325)
library(e1071)
library(forecast)
modelFit <- svm(CompressiveStrength ~., data = training)
# RMSE <- sqrt(sum(testing$CompressiveStrength - predict(modelFit, testing[,1:8]))^2)
accuracy(testing$CompressiveStrength, predict(modelFit, testing[,1:8]))