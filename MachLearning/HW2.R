# Q3: Load the Alzheimer's disease data using the commands:
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
# Find all the predictor variables in the training set that begin with IL. 
# Perform principal components on these variables with the preProcess() function from the caret package. 
# Calculate the number of principal components needed to capture 90% of the variance. 
# How many are there?
trainingIL <- training[,grep("^IL.*",names(training))]
preProc <- preProcess(trainingIL, method="pca", thresh = 0.9)

# Q4: Load the Alzheimer's disease data using the commands:
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Create a training data set consisting of only the predictors with variable names beginning with IL and the diagnosis. 
# Build two predictive models, one using the predictors as they are 
# and one using PCA with principal components explaining 80% of the variance in the predictors. 
# Use method="glm" in the train function. 
# What is the accuracy of each method in the test set? Which is more accurate?

trainingIL <- training[,grep("^IL.*",names(training))]
trainingIL[["diagnosis"]] <- training$diagnosis
testingIL <- testing[,grep("^IL.*",names(testing))]
testingIL[["diagnosis"]] <- testing$diagnosis

# no preprocessing:
model_npc <- train(diagnosis ~ ., method = "glm", data <- trainingIL)
confusionMatrix(testingIL$diagnosis,predict(model_npc, testingIL))

# with preprocessing
preProc <- preProcess(trainingIL[,grep("^IL.*",names(trainingIL))], method="pca", thresh = 0.8)
trainPC <- predict(preProc, trainingIL[,grep("^IL.*",names(trainingIL))])
model_pc <- train(trainingIL$diagnosis ~., methoc = "glm", data = trainPC)
testPC <- predict(preProc, testingIL[,grep("^IL.*",names(testingIL))])
confusionMatrix(testingIL$diagnosis,predict(model_pc, testPC))