set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
library(e1071)
library(caret)
set.seed(325)
model <- train(CompressiveStrength ~ ., data = training, method = "svmRadial")
predcited<-predict(model,testing)
accuracy(predcited, testing$CompressiveStrength)
