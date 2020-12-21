# Course      : CS 513A
# First Name  : Theodore
# Last Name   : Jagodits
# CWID        : 10428834
# Purpose     : Final Problem 1

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

#hclust
hclustfunc <- function(x, method = "complete", dmeth = "euclidean") {    
  hclust(dist(x, method = dmeth), method = method)
}
distfunc <- function(x) as.dist((1-cor(t(x)))/2)
data_dis<-distfunc(data[,!(names(data) %in% c("ADMIT"))])
hclust_res<- hclustfunc(data_dis)
hclust_2<-cutree(hclust_res, 2)
plot(hclust_2)

table(ifelse(hclust_2<1.5,0,1),data$ADMIT)

#kmeans
?kmeans()
kmeans_2<-kmeans(data[,!(names(data) %in% c("ADMIT"))], 2)
kmeans_2$cluster
table(ifelse(kmeans_2$cluster<1.5,0,1),data$ADMIT)
