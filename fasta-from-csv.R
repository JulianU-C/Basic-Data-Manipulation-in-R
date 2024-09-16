#set your working directory, will become FASTA output directory
#setwd("csv file location")

# Load your CSV file into dataframe
dataFile <- read.csv("AMPA results all cath.csv")

# Open a connection to write the FASTA file
writeFASTA <- file("AMPA results.fasta", "w")

# Loop through each row in the dataframe
for (i in 1:nrow(dataFile)) {
  # Write the header line
  cat(dataFile$fastaHeader[i], "\n", file = writeFASTA)
  # Write the sequence line
  cat(dataFile$fastaSequence[i], "\n", file = writeFASTA)
}

# Close the FASTA file
close(writeFASTA)
