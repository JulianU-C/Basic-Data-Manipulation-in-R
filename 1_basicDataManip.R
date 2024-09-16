### Tidy data - Coding Club

library(tidyr)
library(ggplot2)
library(dplyr)
# make sure elongation dataset is loaded (in CC_course_stream1-master dir)

# Convert wide dataframe into longform w/ gather function
# gather(dataframe, key, value, c(columns to gather))
elongation_long <- gather(elongation, Year, Length,
                           c(X2007, X2008, X2009,
                             X2010, X2011, X2012))
# Here's the opposite
elongation_wide <- spread(elongation_long, Year, Length)

# Here's more useful gather for if you have a lot of columns
elongation_long2 <- gather(elongation, Year, Length, c(3:8))

# plots
boxplot(length ~ Year, data = elongation_long,
        xlab = "Year", ylab = "Elongation (cm)",
        main = "Annual growth of Empetrum hermaphroditum")

## Lets fuck around w/ dplyr functions

# 1.Rename variables
elongation_long <- rename(elongation_long,
                          zone = Zone,
                          indiv = Indiv,
                          year = Year)

# 2.Filter rows and select columns - AKA subset
elong_subset <- filter(elongation_long,
                       Zone %in% c(2, 3),
                       Year %in% c("X2009", "X2010", "X2011"))

elong_no.zone <- dplyr::select(elongation_long, -Zone)
# can rename and reorder on the fly!!
elong_no.zone2 <- dplyr::select(elongation_long,
                                YEAR = Year,
                                SHRUB.ID = Indiv,
                                GROWTH = Length)

# 3.Mutate dataset - create columns
elong_total <- mutate(elongation,
                      total.growth = X2007 + X2008 + X2009 +
                        X2010 + X2011 + X2012)

# 4.Group by certain factors to perform operations on chunks of data
# NOTE: you won't see any visible change to the data frame. It creates an internal grouping structure
# which means that every subsequent function you run on it will use these groups, not the whole dataset
elong_grouped <- group_by(elongation_long, Indiv)

# 5.Summarise data with a range of summary statistics
summary1 <- summarise(elongation_long,
                      total.growth = sum(Length))
summary2 <- summarise(elong_grouped,
                      total.growth = sum(Length))
summary3 <- summarise(elong_grouped,
                      total.growth = sum(Length),
                      mean.growth = mean(Length),
                      sd.growth = sd(Length))

# 6.Join data sets based on shared attributes (merging!)
# load new dataframe
treatments <- EmpetrumTreatments  

# we'll merge elongation_long dataframe with treatments dataframe
# don't have to do "Zone" = "Zone" if the column IDs are identical, but just for practice...
experiment <- left_join(elongation_long, treatments,
                        by = c("Indiv" = "Indiv",
                               "Zone" = "Zone"))
experiment <- as.data.frame(experiment)
boxplot(Length ~ Treatment, data = experiment)

# 6a. Alternatively, merge two csv files by column headers, need to be identical 
# Load the data from CSV files
data1 <- read.csv("dataframe1.csv")
data2 <- read.csv("metadata.csv")

# Merge data frames
## Make sure sample identification names are IDENTICAL, here's a way to check
unique_1 <- (data1$SampleID)
unique_2 <- (data2$SampleID)
common_ids <- intersect(unique_1, unique_2)
print(common_ids)

# merge
mergedDataFrame <- merge(data1, data2, by = c('SampleID'), all.x = TRUE)

# Save to a new CSV file
write.csv(mergedDataFrame, "mergedDataFrame.csv", row.names = FALSE)



