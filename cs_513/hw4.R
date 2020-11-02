# Course      : CS 513A
# First Name  : Theodore
# Last Name   : Jagodits
# CWID        : 10428834
# Purpose     : Homework 4 Bayes

#clear environment
rm(list=ls())
#read in data
cancer_data <- read.csv('C:\\Users\\Theo\\Documents\\School\\fall_2020\\cs_513\\breast-cancer-wisconsin.data.csv',na.string="?")

# View data
View(cancer_data)

# Remove any row with a missing value in any of the columns.
cancer_data<-na.omit(cancer_data)

#drop sample number
drops <- c("Sample")
cancer_data <- cancer_data[ , !(names(cancer_data) %in% drops)]

#change to 'Class' target to a factor
cancer_data$Class <- as.factor(cancer_data$Class)

#change numbers to names
levels(cancer_data$Class)[levels(cancer_data$Class)==2] <- "benign"
levels(cancer_data$Class)[levels(cancer_data$Class)==4] <- "malignant"

#view target numbers
table(cancer_data$Class)
#you can see here that there are 444 benign and 239 malignant tumors

#change random seed so that it is reproducible
set.seed(1999)

#get uniform distributiom
gp <- runif(nrow(cancer_data))

#shuffle
cancer_data <- cancer_data[order(gp),]
#you can see in the cancer_data that it is now mixes

head(cancer_data)

#look at distribution
summary(cancer_data[,c(1,2,3,4,5,6,7,8,9)])

#define normalize
normalize <- function(x){
  return( (x-min(x)) / (max(x) - min(x)) )
}
#preprocessingd
cancer_data_n <- as.data.frame(lapply(cancer_data[,c(1,2,3,4,5,6,7,8,9)], normalize))

#numbers for rows for train and test
total_rows = nrow(cancer_data_n)
train_number = as.integer(total_rows * .7)

cancer_data_train <- cancer_data_n[1:train_number - 1, ]
cancer_data_test <- cancer_data_n[train_number: total_rows, ]
cancer_data_train_target <- cancer_data[1:train_number - 1, 10]
cancer_data_test_target <- cancer_data[train_number: total_rows, 10]

#install KNN
install.packages("e1071")
require("e1071")

bayes_model <- naiveBayes(cancer_data_train_target ~., data =cancer_data_train)
bayes_predict <- predict(bayes_model,cancer_data_test  )
#can see 9 wrong
table(cancer_data_test_target, bayes_predict)
