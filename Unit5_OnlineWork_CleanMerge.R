library(downloader)
getwd()
setwd("C:/Projects/SMU_R_HW")
list.files()

download("https://raw.githubusercontent.com/thoughtfulbloke/faoexample/master/appleorange.csv", destfile="appleorange.csv")

download("https://raw.githubusercontent.com/thoughtfulbloke/faoexample/master/stability.csv", destfile="stability.csv")

list.files()

aoraw <- read.csv("appleorange.csv", stringsAsFactors = FALSE, header=FALSE)
str(aoraw)

aodata <- aoraw[3:700,]
names(aodata) <- c("country", "countrynm", "products", "productnmb", "tonnes", "year")

str(aodata)
aodata$countrynm <- as.integer(aodata$countrynm)
fslines <- which(aodata$country == "Food supply quantity (tonnes) (tonnes)")
aodata <- aodata[(-1 * fslines),]

aodata$tonnes <- gsub("\xca", "", aodata$tonnes)
aodata$tonnes <- gsub(", tonnes \\(\\)", "", aodata$tonnes)

aodata$tonnes <- as.numeric(aodata$tonnes)
str(aodata)

aodata$year <- 2009

#Create Apples file
apples <- aodata[aodata$productnmb == 2617, c(1,2,5)]
str(apples)

names(apples)[3] <- "apples"

# Oranges
oranges <- aodata[aodata$productnmb == 2611, c(2,5)]
names(oranges)[2] <- "oranges"
str(oranges)

#which country is missing oranges?
missingOranges <- which(is.na(oranges$oranges))
missingOranges
oranges[160,]
which(apples$countrynm == 213)
apples[160,]


#merge the two files
cleanao2 <- merge(apples, oranges, by="countrynm", all=TRUE)
str(cleanao2)
#  much better formula! than above
cleanao2[!(complete.cases(cleanao2)),]

#using dcast to melt original file
library(reshape2)
head(aodata)
cleanao3 <- dcast(aodata[,c(1:3,5)], formula = country +countrynm ~ products, value.var="tonnes")
head(cleanao3)

#renames cols
names(cleanao3)[3:4] <- c("apples", "oranges")

#find out whats missing at a macro level
cleanao2[!(complete.cases(cleanao2)),]
cleanao3[!(complete.cases(cleanao3)),]

