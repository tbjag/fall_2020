#################################################
#  Company    : Stevens 
#  Project    : EDA 
#  Purpose    : use EDA to analyze breast-cancer-wisconsin.data.csv
#  First Name : Theodore
#  Last Name  : Jagodits
#  Id			    : 10428864
#  Date       : 10/20/2020
#  Comments   :

#homework 2 cs513 / Theodore Jagodits
#uses breast-cancer-wisconsin.data.csv
#i pledge my honor that I have abided by the Stevens honor system. 

#remove global vars
rm(list=ls())

#doing part 2 right here
wisc_data <- read.csv("School/fall_2020/cs_513/bre?st-cancer-wisconsin.data.csv", na.string = "?")

#put into dataframe
df<- data.frame(wisc_data)
View(df)
#find the NA in the cols
colSums(is.na(df))
#we see 16 missing vals in f6

#Replacing the missing values with the "mean" of the column.
for(i in 1:ncol?df)){
  df[is.na(df[,i]), i] <- mean(df[,i], na.rm = TRUE)
}
View(df)
#Displaying the frequency table of "Class" vs. F6
temp_table <- table(df$Class, df$F6)
ftable(temp_table)

#Displaying the scatter plot of F1 to F6, one pair at a time
plot(df[2:7], main?= "Scatter Plot of F1 to F6", ph = 10, col = 2)

#Show histogram box plot for columns F7 to F9
boxplot(df[8:10])

#remove global vars
rm(list=ls())

wisc_data <- read.csv("School/fall_2020/cs_513/breast-cancer-wisconsin.data.csv", na.string = "?")

omitted?data<-na.omit(wisc_data)
View(omitted_data)
