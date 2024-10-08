## Inspired by "Efficient data manipulation Coding Club 2" ##
# Using pipes and dplyr
# The pipe operator %>% is available in the magrittr package
# tidyverse pakcages load %>% automatically
# %>% shortcut = ctrl + shift + m
# Think of the %>% operator as "and then"

library(dplyr)
library(ggplot2)
library(tidyr)

## 1) Intro to Pipes
# load tree dataframe, available at Coding Club https://ourcodingclub.github.io/
trees <- read.csv("trees.csv")
head(trees)

# Let's count the number of trees per species (example without %>%)
# create an internal grouping structure, so that the next function acts on groups separately
trees.grouped <- group_by(trees, CommonName)
# use length to count the number of rows (trees) for each group (species)
trees.summary <- summarise(trees.grouped, count = length(CommonName))
# alternatively w/dplyr
trees.summary <- tally(trees.grouped)

# this is where piping %>% will change your game, no longer need to create an intermediary dataframe to run the tally function
# takes object on the left and passes it to the function on the right 

# Let's count the number of trees per species (example with %>%)
trees.summary_pipe <- trees %>%
  group_by(CommonName) %>%
  tally()  # don't need anything because CommonName is passed through the pipe!

# Pipes only work on dataframe objects!

## 2) More Functions of dplyr

# 2a) quickly generate a summary dataframe
summ.all <- summarise_all(trees, mean)

# 2b) case_when() -for reclassifying values or factors
vector <- c(1:10)
# give conditions: if inferior to 5, return A, if not, return B
ifelse(vector < 5, "A", "B")
# case_when() is a generalization of ifelse() that lets you assign more than two outcomes
vector2 <- c("What am I?", "A", "B", "C", "D")

case_when(vector2 == "What am I?" ~ "I am the walrus",
          vector2 %in% c("A", "B") ~ "goo",
          vector2 == "C" ~ "ga",
          vector2 == "D" ~ "joob")

## 3) Changing factor levels or create categorical variables
# Shows all the species names
unique(trees$LatinName) 
# Create a new column and fill with Genus name
trees.genus <- trees %>%
  mutate(Genus = case_when(               
    # creates the genus column and specifies conditions
    # grepl looks for specified patterns in the data
    # we have Latin names but want a column w/ only genera 'Genus'
    grepl("Acer", LatinName) ~ "Acer",
    grepl("Fraxinus", LatinName) ~ "Fraxinus",
    grepl("Sorbus", LatinName) ~ "Sorbus",
    grepl("Betula", LatinName) ~ "Betula",
    grepl("Populus", LatinName) ~ "Populus",
    grepl("Laburnum", LatinName) ~ "Laburnum",
    grepl("Aesculus", LatinName) ~ "Aesculus",
    grepl("Fagus", LatinName) ~ "Fagus",
    grepl("Prunus", LatinName) ~ "Prunus",
    grepl("Pinus", LatinName) ~ "Pinus",
    grepl("Sambucus", LatinName) ~ "Sambucus",
    grepl("Crataegus", LatinName) ~ "Crataegus",
    grepl("Ilex", LatinName) ~ "Ilex",
    grepl("Quercus", LatinName) ~ "Quercus",
    grepl("Larix", LatinName) ~ "Larix",
    grepl("Salix", LatinName) ~ "Salix",
    grepl("Alnus", LatinName) ~ "Alnus")
  )

# Another alternative - using tidyr
tree.genus2 <- trees %>% 
  tidyr::separate(LatinName, c ("Genus", "Species"),
                  sep = " ", remove = FALSE) %>% 
  dplyr::select(-Species)
# we're creating two new columns in a vector (genus name and species name), "sep" refers to the separator, 
# here space between the words, and remove = FALSE means that we want to keep the original column LatinName in the data frame

# 3b) another example of reclassifying a factor
# Height variables beings classified into Short, Medium, and Tall variable
tree.genus1 <- trees.genus %>% 
  mutate(Height.cat = 
           case_when(Height %in% 
                       c("Up to 5 meters",
                         "5 to 10 meters") ~ "Short",
                         Height %in%
                           c("10 to 15 meters",
                             "15 to 20 meters") ~ "Medium", 
                         Height == "20 to 25 meters" ~ "Tall")
                     )
tree.genus1$Height.cat <- as.factor(tree.genus1$Height.cat)\

# 3c) Reordering factor levels
levels(tree.genus1$Height.cat)  # shows default factor levels

tree.genus1$Height.cat <- factor(tree.genus1$Height.cat,
                                 levels = c('Short', 'Medium', 'Tall'), 
                                 labels = c('SHORT', 'MEDIUM', 'TALL'))   

levels(tree.genus1$Height.cat)  # a new order and new names for the levels

## 4) Subset our tree data to fewer genera
trees.five <- tree.genus1 %>% 
  filter(Genus %in% c("Acer",
                      "Fraxinus",
                      "Salix",
                      "Aesculus",
                      "Pinus"))




