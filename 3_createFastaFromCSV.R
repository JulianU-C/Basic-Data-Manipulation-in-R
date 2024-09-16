# Do you have a metadata file with sequences in a column and headers in another? Well use this to make a .FASTA file for them

#set your working directory, will become FASTA output directory
setwd("csv file location")

# load your CSV file
dataFile <- read.csv("inputDataSet.csv")

# open a connection to write the FASTA file
writeFASTA <- file("outputFileName.fasta", "w")

# iterate through each row in the dataframe
for (i in 1:nrow(dataFile)) {
  # Write the header line, fastaHeader = column ID with headers
  cat(dataFile$fastaHeader[i], "\n", file = writeFASTA)
  # Write the sequence line, fastaSeqeunce = column ID with seqeunces
  cat(dataFile$fastaSequence[i], "\n", file = writeFASTA)
}

# Close the FASTA file
close(writeFASTA)
