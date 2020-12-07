# Course      : CS 513A
# First Name  : Theodore
# Last Name   : Jagodits
# CWID        : 10428834
# Purpose     : Homework #9

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

hclustfunc <- function(x, method = "complete", dmeth = "euclidean") {    
  hclust(dist(x, method = dmeth), method = method)
}
distfunc <- function(x) as.dist((1-cor(t(x)))/2)
data_dis<-distfunc(data[,!(names(data) %in% c("diagnosis"))])
hclust_res<- hclustfunc(data_dis)
hclust_2<-cutree(hclust_res, 2)
plot(hclust_2)

table(ifelse(hclust_2<1.5,"M","B"),data$diagnosis)

#kmeans
kmeans_2<-kmeans(data[,!(names(data) %in% c("diagnosis"))], 2)
kmeans_2$cluster
table(ifelse(kmeans_2$cluster<1.5,"M","B"),data$diagnosis)
