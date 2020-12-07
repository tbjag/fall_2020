# Course      : CS 513A
# First Name  : Theodore
# Last Name   : Jagodits
# CWID        : 10428834
# Purpose     : Homework 8

#clear environment
rm(list=ls())
#read in data
data <- read.csv('C:\\Users\\Theo\\Documents\\School\\fall_2020\\cs_513\\wisc_bc_ContinuousVar.csv')

#view data
View(data)

#check for null values
apply(data, 2, function(x) any(is.na(x)))
#does not have any

#drop ID
data = data[,!(names(data) %in% c("id"))]

#split into test and train
index<-sort(sample(nrow(data ),round(.25*nrow( data))))
training<- data[-index,]
test<- data[index,]
index <- seq (1,nrow(data),by=5)
test<- data[index,]
training<-data[-index,]

#install.packages("neuralnet")
library("neuralnet")
?neuralnet()
neural_net<- neuralnet( diagnosis~., data = data , hidden=5, threshold=0.01, stepmax = 1e7)

#Plot the neural network
plot(neural_net)

# test should have only the input columns
ann <-compute(neural_net , test[,!(names(test) %in% c("diagnosis"))])
ann$net.result 

predspp <- factor(c("M", "B"))[apply(ann$net.result, MARGIN=1, FUN=which.max)]

table(Actual=test$diagnosis,prediction=predspp)

wrong<- (test$diagnosis!=predspp)
error_rate<-sum(wrong)/length(wrong)
error_rate
