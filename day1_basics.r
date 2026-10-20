#Day 1 Basics: Loading and Filtering Data
#Script name: day1_basics.R

#1. Load a built-in dataset - 
data("mtcars")

#2. Inspect the first few rows of the dataset
head(mtcars)
#-------------------------------------------
str(mtcars)
View(mtcars) #--same as browse in stata

#3.Filter rows based on 2 condition criteria:
# Condition 1: Miles per gallon (mpg) greater than 20
# Condition 2: Number of cylinders (cyl) equal to either 4 or 6 (i.e. less than or equal to 6)

filtered_cars <- subset(mtcars, mpg >20 & cyl <= 6)

print(filtered_cars)
