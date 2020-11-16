# Course      : CS 513A
# First Name  : Theodore
# Last Name   : Jagodits
# CWID        : 10428834
# Purpose     : Midterm Q4

#clear environment
rm(list=ls())
#read in data gets rid of null values at the start
census_data <- read.csv('C:\\Users\\Theo\\Documents\\School\\fall_2020\\cs_513\\adult_income_EDA_midterm.csv',na.string=" ?")
# View data
View(census_data)

#print descriptive stats
for (var in colnames(census_data)) {
  if (class(census_data[,var])=="integer"){
    print(summary(census_data[var]))
    print(sd(as.numeric(unlist(census_data[var]))))
  }
}


colSums(is.na(census_data))
#replaces NA with the most common values of the column -- THERE ARE NO median vals for numeric
Mode <- function (x, na.rm) {
  xtab <- table(x)
  xmode <- names(which(xtab == max(xtab)))
  if (length(xmode) > 1) xmode <- ">1 mode"
  print(xmode)
  return(xmode)
}

for (var in 1:ncol(census_data)) {
  if (class(census_data[,var])=="integer") {
    census_data[is.na(census_data[,var]),var] <- median(census_data[,var], na.rm = TRUE)
  } else if (class(census_data[,var]) %in% c("character", "factor")) {
    census_data[is.na(census_data[,var]),var] <- Mode(census_data[,var], na.rm = TRUE)
  }
}

#boxplot
boxplot(census_data[c("Age", "Education_Years", "Hours_worked_Perweek")])
