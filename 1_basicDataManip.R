### Tidy data - Coding Club
A lost of these exampels are from the Coding Club course https://ourcodingclub.github.io/
# load libraries and data
library(tidyr)
library(ggplot2)
library(dplyr)
elongation <- #load elongation dataframe here, can get from Coding Club (see above link)

## HELPFUL QUICK FUNCTIONS
# 1. Convert wide dataframe into longform w/ gather function
# gather(dataframe, key, value, c(columns to gather))
elongation_long <- gather(elongation, Year, Length, c(X2007, X2008, X2009, X2010, X2011, X2012))

# 1a. Here's the opposite, convert long form to wide form
elongation_wide <- spread(elongation_long, Year, Length)

# 1b. Here's more useful gather for if you have a lot of columns
elongation_long2 <- gather(elongation, Year, Length, c(3:8))

# 2. Remove a character from a column in a dataframe with gsub()
Data$Column1 <- gsub("Character","", as.character(Data$Column1)

## MANIPULATION WITH dplyr FUNCTIONS
# 1.Rename variables
elongation_long <- rename(elongation_long,
                          zone = Zone,
                          indiv = Indiv,
                          year = Year)

# 2.Filter rows and select columns - AKA subset
# here I'm filtering rows that aren't in zone 2 or 3 or in years 2009-2011
elong_subset <- filter(elongation_long,  Zone %in% c(2, 3), Year %in% c("X2009", "X2010", "X2011"))
  # remove rows
elong_subset <- filter(!((elongation_long,  Zone %in% c(2, 3), Year == "X2012")
# subset by column
dataSubset <- data1 %>% select(Column1, Column2, Column3)
  # OR
dataSubset <- data1 %>% select(-Column4, -Column5, -Column6)


# can rename and reorder on the fly!!
elong_no.zone2 <- dplyr::select(elongation_long,
                                YEAR = Year,
                                SHRUB.ID = Indiv,
                                GROWTH = Length)

# 3.Mutate dataset - create columns
elong_total <- mutate(elongation, total.growth = X2007 + X2008 + X2009 + X2010 + X2011 + X2012)

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

# merge, 'all = TRUE' will include all columns and rows and fill voids with NA
mergedDataFrame <- merge(data1, data2, by = c('SampleID'), all.x = TRUE)

# Save to a new CSV file
write.csv(mergedDataFrame, "mergedDataFrame.csv", row.names = FALSE)

## here's another example when I needed to add duplicate values for "Sequence.AMPA" into one column
## separated by a "|" and into the same row name "transcript_id"
library(dplyr)
data1 <- read.csv("AMPAseqs.csv")
data2 <- read.csv("TableS2.csv")

dataAMPA <- data1 %>% 
  select(transcript_id, Seqeunce.AMPA) %>% 
  group_by(transcript_id) %>% 
  summarise(Sequence.AMPA = paste(Seqeunce.AMPA, collapse = " | "),
            .groups = "drop")

mergeDataframe <- merge(dataAMPA, data2, by = c("transcript_id"), all = TRUE)
write.csv(mergeDataframe, "AMPAseqsTableS2.csv", row.names = FALSE)
# instead of having... 
#transcript1 AATG
#transcript1 AAGT 
#transcript1 AGTG 
#in multiple rows, I'll have...
#transcript1 AATG | AAGT | AGTG all in one row

