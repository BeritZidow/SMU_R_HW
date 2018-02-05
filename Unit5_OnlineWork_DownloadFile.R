# Week 5 lecture assignment

# Simple CSV files for download
# https://vincentarelbundock.github.io/Rdatasets/datasets.html

myURL <- "https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/datasets/BJsales.csv"
temp <- tempfile()
download.file(myURL, temp)

temp
BJSales <- read.csv(temp)
head(BJSales)

dim(BJSales)
# 150   3

names(BJSales)
#  "X"       "time"    "BJsales"

sapply(BJSales, class)
#        X      time   BJsales 
#"integer" "integer" "numeric" 

class(BJSales)
#"data.frame"

unlink(temp)
