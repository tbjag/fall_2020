# Course      : CS 513A
# First Name  : Theodore
# Last Name   : Jagodits
# CWID        : 10428834
# Purpose     : Midterm Q5

#clear environment
rm(list=ls())
#read in data
naive_data <- read.csv('C:\\Users\\Theo\\Documents\\School\\fall_2020\\cs_513\\adult_income_Bayes_V2.csv',na.string=" ?")

#view
View(naive_data)

#remove null vals rows
naive_data<-na.omit(naive_data)

#split up into train and test
test <- naive_data[seq(1, nrow(naive_data), 4),]
training <- naive_data[!(naive_data %in% test), ]

test_y <- test$Income
test_X <- test[, c("Workclass","Education", "Marital_status", "Occupation", "Relationship", "race", "Gender", "Native_country")]
train_y <- training$Income
train_X <- training[, c("Workclass","Education", "Marital_status", "Occupation", "Relationship", "race", "Gender", "Native_country")]

#install KNN
install.packages("e1071")
require("e1071")

bayes_model <- naiveBayes(train_y ~., data =train_X)
bayes_predict <- predict(bayes_model,test_X  )

t <- table(test_y, bayes_predict)

View(t)
wrong<-sum(bayes_predict!=test_y)
error_rate<-wrong/length(bayes_predict)
print(error_rate)
