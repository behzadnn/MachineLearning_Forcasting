#install.packages("lubridate")
#install.packages("forecast")
library(lubridate)  # For year() function below
library(forecast)
dat = read.csv("gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)
fit<-bats(tstrain)
h <- dim(testing)[1]

# forecast the model for remaining time points
fcast <- forecast(fit, level = 95, h = h)

# get the accuracy
accuracy(fcast, testing$visitsTumblr)


# check what percentage of times that the actual number of visitors was within
# 95% confidence interval

result <- c()
l <- length(fcast$lower)

for (i in 1:l){
  x <- testing$visitsTumblr[i]
  a <- fcast$lower[i] < x & x < fcast$upper[i]
  result <- c(result, a)
}

sum(result)/l * 100