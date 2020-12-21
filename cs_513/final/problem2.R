# Course      : CS 513A
# First Name  : Theodore
# Last Name   : Jagodits
# CWID        : 10428834
# Purpose     : Problem 2

#clear environment
rm(list=ls())
#read in data
data <- read.csv('C:\\Users\\Theo\\Documents\\School\\fall_2020\\cs_513\\final\\AdmissionB.csv')

#view data
View(data)

#check for null values
apply(data, 2, function(x) any(is.na(x)))
#does not have any

#drop ID
data = data[,!(names(data) %in% c("Applicant"))]

#split into test and train
test <- data[seq(1, nrow(data), 4),]
training <- data[-seq(1, nrow(data), 4),]

#install.packages("neuralnet")
library("neuralnet")
?neuralnet()
neural_net<- neuralnet( ADMIT~., data = data , hidden=6, threshold=0.01, stepmax = 1e7)

#Plot the neural network
plot(neural_net)

# test should have only the input columns
ann <-compute(neural_net , test[,!(names(test) %in% c("ADMIT"))])
ann$net.result 

predspp <- factor(c(0, 1))[apply(ann$net.result, MARGIN=1, FUN=which.max)]

table(Actual=test$ADMIT,prediction=predspp)

wrong<- (test$ADMIT!=predspp)
error_rate<-sum(wrong)/length(wrong)
error_rate
