# File: ric_pkg_build_01.R
# Date: Nov 1, 2013
# Author: richard.zijdeman@iisg.nl
# Project: github / roc
# Last Change: -


## loading libraries ####
library("data.table")

## loading data ####
# Read in sample data with HISCO's. File from http://collab.iisg.nl
mmetro <- read.csv("./data/original/mmetro/lndn1866_01.csv",
                   header = TRUE,
                   sep = "\t")
hiscam_u1 <- data.table(read.table("./data/original/hiscam/hiscam_u1_v1_3.dat",
                        header = TRUE,
                        sep = "\t"), key = "hisco")

roc <- function(hisco.data, classification, version, scale)
  {
  version <- "1.3"
  scale   <- "U1"
  
  # convert to data.table
  hisco.data  <- data.table(hisco.data, key = "hisco")
  hisco.data  <- merge(hisco.data,classification)
  return(hisco.data)
  }

## this returns a merged dataset, but
## - the object is not put in the workspace
## - it removes the non-merged values









