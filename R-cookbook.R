############ How to Load packages and Set the working Directory ###########
# Suppress warnings
options(warn=-1)

# remove all the existing variables
rm(list = ls())

# Get the current working directory
getwd()

# Change the working directory if required
setwd("/Users/akyare/Documents/R programming/Tests")

# get to understand what objects are already available in the environment
ls()

# Load packages that are needed
install.packages("ggplot2")      # For Plotting
install.packages("stringr")      # For String manipulation
install.packages("lubridate")    # For date manipulation
install.packages("reshape2")     # For doing some operations with vectors
install.packages("data.table")   # A faster data frame
install.packages("dplyr")        # Has very useful functions
install.packages("PerformanceAnalytics") # Performance Analytics
install.packages("zoo")          # Time series
install.packages("tseries")      # Time series related
install.packages("xts")          # Time series related
install.packages("Hmisc")        # Very useful set of functions for analysis
install.packages("scales")

#Use the package in a R script
library("ggplot2")
library("stringr")
library("lubridate")
library("reshape2") 
library("data.table")
library("dplyr")
library("PerformanceAnalytics")
library("zoo")
library("tseries")
library("xts")
library("Hmisc")
library("scales")

################# Basic Building Blocks
# Number vectors
vectNums = c(1,2,3,4,5,6)
vectNums
vectNums * 2 + 5
vectNums^2
length(vectNums)

vectNums = c(vectNums, vectNums^2)
length(vectNums)

# string vectors
vectStrings = c('A', 'B', 'C', 'D')

######################### Gennerating Sequences Vectors #################
seq(-1, 1, by=0.1) 
# Generate sequences to form a vector
posNum = seq(1:100)
# Append to an existing vector
posNum = c( posNum, seq(300,400,2))
# length of the vector - How many elements
length(posNum)

######################### Repeat occurences ######################
# Repeat a sequence few times
rep(1:10, 4)
## first days of years
seq(as.Date("1910/1/1"), as.Date("1999/1/1"), "years")
# by month
seq(as.Date("2000/1/1"), by = "month", length.out = 12)
# quarters
seq(as.Date("2000/1/1"), as.Date("2003/1/1"), by = "quarter")

######################### Concatenate Strings ####################

str1= c("A","b","c","test")
paste0(str1,collapse = "|")

######################## Reading a CSV File #####################
stock_prices = read.csv("price-stock.csv")
# Check the dimensions
dim(stock_prices)
nrow(stock_prices)
ncol(stock_prices)

######### Structure, Summary and Descriptives ########
summary(stock_prices)
dim(stock_prices)
str(stock_prices)
str(stock_prices$Date)
stock_prices$revisedDate = as.Date(stock_prices$Date, "%Y-%m-%d")
str(stock_prices$revisedDate)

############### Add columns to the data frame ############
stock_prices$year = year(stock_prices$revisedDate)
stock_prices$month = month(stock_prices$revisedDate)

############ Subsetting Dataframe ###################
# get the first 10 rows
stock_prices[1:10,]
stock_prices[1:10,c(1,4,5)]
stock_prices[1:10,c("Date","Close")]

# get everything for the month March
stock_prices[stock_prices$month==3,c("Low","Close")]
stock_prices[stock_prices$month==3 & stock_prices$Volume>6000000,]

# the output of subset commands can be chained and ranges can be excluded as wel
stock_prices[c(1:10),][-c(1:5),]

# rename the column names if required to make it meaningful and easy to use
colnames(stock_prices)
names(stock_prices)[2:4] = paste0(rep("price_",3),c("Open","High","Low"))
names(stock_prices)

############### organizing the variables into Bins ##############
bin_stocks = stock_prices[,c("price_Open","price_High")]
# Bin the variables by quantiles
bin_stocks$price_Open_bin = cut2(bin_stocks$price_Open, g =5)
summary(bin_stocks$price_Open_bin)

######continue