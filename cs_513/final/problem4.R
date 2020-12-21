# Course      : CS 513A
# First Name  : Theodore
# Last Name   : Jagodits
# CWID        : 10428834
# Purpose     : Problem 4

#clear environment
rm(list=ls())
#read in data
data <- read.csv('C:\\Users\\Theo\\Documents\\School\\fall_2020\\cs_513\\final\\Admission_catB.csv')

#view data
View(data)

#check for null values
apply(data, 2, function(x) any(is.na(x)))
#does not have any

#drop ID
data = data[,!(names(data) %in% c("Applicant"))]

#find unqique values
unique(data$GPA)
unique(data$GRE)

#label encode
data$GPA<-factor(data$GPA , levels = c("Low","Medium","High","very High") , labels = c("1","2","3","4"))
data$GRE<-factor(data$GRE , levels = c("Low","Medium","High","very High") , labels = c("1","2","3","4"))

data$ADMIT<- factor(data$ADMIT , levels = c("0","1") , labels = c("Reject","Admit"))

#split into test and train
test <- data[seq(1, nrow(data), 4),]
training <- data[-seq(1, nrow(data), 4),]

#install C50
install.packages("C50")
require("C50")

#CART model
C50_class<-C5.0( ADMIT~.,data=training)
summary(C50_class)
C50_predict<-predict(C50_class,test, type="class") 

table(test$ADMIT, C50_predict)
