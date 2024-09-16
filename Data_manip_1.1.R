### Data manipulation 1 - Coding Club

# Files load from 04_Data_Manip...
elongation <- EmpetrumElongation

# Check import and preview data
head(elongation)  # first few obs
str(elongation)   # types of variables

# Information!! - this is subsetting
elongation$Indiv   # prints out all the ID codes in data set
length(unique(elongation$Indiv)) # number of distinct shrubs

# How we get the value in the 2nd row, 5th column
elongation[2,5]

# or for all of row 6
elongation[6, ]

# trick it up
elongation[6, ]$Indiv

### This method (above) is actually not a 
### practical way to subset data, what if you add rows later on?? 
### Logical operations can access specific parts of the data

# Lets access values for Individual 603
elongation[elongation$Indiv == 603, ]

# More subsetting w/ one condition
elongation[elongation$Zone < 4, ]    # returns only data from zones 2 and 3

# More subsetting w/ two conditions
elongation[elongation$Zone == 2 | elongation$Zone == 7, ]   # only zones 2 & 7

# Another banger
elongation[elongation$Zone == 2 & elongation$Indiv %in% c(300:400), ]

# above - returns data for shrubs in zone 2 whose ID numbers are b/w 300 and 400



## CHANGING VARIABLE NAMES AND VALUES IN A DATA FRAME

# create working copt of our object
elong2 <- elongation

# Now suppose you want to change the name of a column: you can use the names() function
# Used on its own, it returns a vector of the names of the columns. Used on the left side of the assign arrow, it overwrites all or some of the names to value(s) of your choice

names(elong2)   # returns names of the columns

names(elong2)[1] <- "zone"   # calls 1st element of names vector and changes it to zone

# Fixing a mistake in your data
elong2[elong2$Indiv == 373, ]$X2008 <- 5.7   # you get it!!!

## CREATING A FACTOR

# Check the classes -- display the structure str()
str(elong2)   

# The zone column shows as integer data (whole numbers), but it's really a grouping factor (the zones could have been called A, B, C, etc.) Let's turn it into a factor:

elong2$zone <- as.factor(elong2$zone)    # convert and overwrite

str(elong2$zone)

## CHANGING A FACTORS LEVLS

levels(elong2$zone)

levels(elong2$zone) <- c("A", "B", "C", "D", "E", "F")


##### End of part 1 of Data Manip 1 see next R file 