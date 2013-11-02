# File: ric_pkg_build_01.R
# Date: Nov 2, 2013
# Author: richard.zijdeman@iisg.nl
# Project: github / roc
# Last Change: -
## Nov 2, 2013: version 1 now contains information that shows that there are
## duplicates in HISCAM. The file saves a file with unique hisco's only at the
## end. Reading that file in version ric_pkg_build_02.R

## loading libraries ####
library("data.table")

## loading data ####
# Read in sample data with HISCO's. File from http://collab.iisg.nl
mmetro <- read.csv("./data/original/mmetro/lndn1866_01.csv",
                   header = TRUE,
                   sep = "\t")
hiscam_u1 <- data.table(read.table
                        ("./data/derived/hiscam_u1v1_3_unique_hisco.dat",
                        header = TRUE,
                        sep = "\t"), key = "hisco")

rocc <- function(hisco.data, classification, version, scale)
{
  version <- "1.3"
  scale   <- "U1"
  
  # convert to data.table
  hisco.data  <- data.table(hisco.data, key = "hisco")
  hisco.data  <- merge(hisco.data,classification, all.x = T)
  return(hisco.data$hiscam)
  
}
rocc(mmetro, hiscam_unq)

mmetro$hiscam_added <- rocc(mmetro,hiscam_unq)

# for next time: 
# make sure you can add multiple variables: e.g. groom's hisco, bride's hisco
# and that all of these get matched in one go, if you'd like
# then: add other generic parameter for hisco
# e.g. something like: rocc(file, vector of variables to code,
#                            input (hisco), output, type, version)










