# Course      : CS 513A
# First Name  : Theodore
# Last Name   : Jagodits
# CWID        : 10428834
# Purpose     : Midterm Q6

#clear environment
rm(list=ls())
#read in data
data <- read.csv('C:\\Users\\Theo\\Documents\\School\\fall_2020\\cs_513\\adult_income_Dtree_v2.csv',na.string=" ?")

View(data)

#remove null vals rows
data<-na.omit(data)

#split up into train and test
test <- data[seq(1, nrow(data), 4),]
training <- data[!(data %in% test), ]

#train and test
test_y <- test$Income
test_X <- test[, c("Age","Workclass","Education", "Marital_status", "Occupation", "Relationship", "race", "Gender","Hours_worked_Perweek", "Native_country")]
train_y <- training$Income
train_X <- training[, c("Age","Workclass","Education", "Marital_status", "Occupation", "Relationship", "race", "Gender","Hours_worked_Perweek", "Native_country")]

#install CART
install.packages("rpart")
require("rpart")

#CART model
CART_class<-rpart( train_y ~.,data=train_X)
CART_predict<-predict(CART_class,test_X, type="class") 
t <- table(test_y, CART_predict)

View(t)
wrong<-sum(CART_predict!=test_y)
error_rate<-wrong/length(CART_predict)
print(error_rate)

