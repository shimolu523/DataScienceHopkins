# Load the cell segmentation data from the AppliedPredictiveModeling package using the commands:

library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rpart)
library(rattle)
library(rpart.plot)

# 1. Subset the data to a training set and testing set based on the Case variable in the data set. 
# 2. Set the seed to 125 and fit a CART model with the rpart method using all predictor variables and default caret settings. 
# 3. In the final model what would be the final model prediction for cases with the following variable values:
#  a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2 
# b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100 
# c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100 
# d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2 

set.seed(125)
inTrain <- segmentationOriginal$Case =="Train"
training <- segmentationOriginal[inTrain,]
testing <- segmentationOriginal[-inTrain,]
modelFit <- train(Class ~ . , method = 'rpart', data =  training)
print(modelFit$finalModel)
fancyRpartPlot(modelFit$finalModel)

# Q3: Load the olive oil data using the commands:

library(pgmm)
library(tree)
data(olive)
olive = olive[,-1]

# These data contain information on 572 different Italian olive oils from multiple regions in Italy. 
# Fit a classification tree where Area is the outcome variable. T
# hen predict the value of area for the following data frame using the tree command with all defaults

modelFit <- tree(Area ~ ., data = olive)
newdata = as.data.frame(t(colMeans(olive)))
predResult <- predict(modelFit, newdata)

# Q4: Load the South Africa Heart Disease Data and create training and test sets with the following code:
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

# Then set the seed to 13234 and fit a logistic regression model (method="glm", be sure to specify family="binomial") 
# with Coronary Heart Disease (chd) as the outcome and age at onset, 
# current alcohol consumption, obesity levels, cumulative tabacco, type-A behavior, and low density lipoprotein cholesterol as predictors. 
# Calculate the misclassification rate for your model using this function and a prediction on the "response" scale:

missClass = function(values,prediction){
  sum(((prediction > 0.5)*1) != values)/length(values)}

set.seed(13234)
modelFit <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, method ="glm", family = "binomial", data = trainSA)
predResult_train <- predict(modelFit, trainSA[,1:9])
predResult_test <- predict(modelFit, testSA[,1:9]) # without the chd (output)
missClass(trainSA[,10], as.numeric(predResult_train))
missClass(testSA[,10], as.numeric(predResult_test))

# Q5: Load the vowel.train and vowel.test data sets:
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

# Set the variable y to be a factor variable in both the training and test set. 
# Then set the seed to 33833. Fit a random forest predictor relating the factor variable y to the remaining variables. 
# Read about variable importance in random forests here: http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm#ooberr 
# The caret package uses by defualt the Gini importance. 
# Calculate the variable importance using the varImp function in the caret package. What is the order of variable importance?

set.seed(33833)
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
modelFit <- train(y ~., method = "rf", data = vowel.train)
varImp(modelFit)