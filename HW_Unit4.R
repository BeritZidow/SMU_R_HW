#Unit 4 Live Session HW
install.packages("fivethirtyeight")
install.packages("devtools")
devtools::install_github("rudeboybert/fivethirtyeight", build_vignettes = TRUE)


library(fivethirtyeight)
library(dplyr)


# Bechdel data set (note that data is lazy loaded so one 
#can also just access `bechdel` without running `data(bechdel)`):
data(bechdel)
head(bechdel)
?bechdel
# If using RStudio:
View(bechdel)

# To see a list of all data sets:
#Q1

# To see a more detailed list of all data sets, see the package vignette:
vignette("fivethirtyeight", package = "fivethirtyeight")
#http://fivethirtyeight.com/features/the-economic-guide-to-picking-a-college-major/

listing <- data(package = "fivethirtyeight")
head(listing, 5)
str(listing)
#[18,] "college_recent_grads" 

df <- fivethirtyeight::college_recent_grads
head(df)

str(df)


#Q2
names(df)
ncol(df)

unique(df$major_category)

# creates matrix by not good for barplot
#major_count <- count(df, major_category)
#major_count

par(las=2)
counts <- table(df$major_category)
y <- barplot(counts, main="Count by Major", col="red", xlab="count", ylab="Major", horiz=TRUE, cex.names = 0.5)
text(x,y,names(counts))

getwd()

# Write to csv file w/o row labels
write.csv(df, file = "major_data_538.csv",row.names=FALSE)

list.files()