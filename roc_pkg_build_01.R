# File: ric_pkg_build_01.R
# Date: Nov 1, 2013
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
hiscam_u1 <- data.table(read.table("./data/original/hiscam/hiscam_u1_v1_3.dat",
                        header = TRUE,
                        sep = "\t"), key = "hisco")


## running into errors with duplicats in hiscam_u1
dub.hisco <- subset(hiscam_u1$hisco,
                    duplicated(hiscam_u1$hisco))



hiscam_u1.sub <- subset(hiscam_u1,
                    hiscam_u1$hisco %in% dub.hisco)
## oops problematic: not just dupliates, but duplicate
## hisco's with different values

hiscamxls <- read.xlsx("./data/original/hiscam/hiscam_u1-3.xlsx",
                       sheetName = "hiscam_u1-3.xls")


write.table(hiscam_u1.sub, 
            file = "./data/derived/hiscam_dbl_hisco_u1v1_3.dat",
            row.names = FALSE,
            col.names = TRUE)

hiscam_unq <- subset(
  hiscam_u1[order(hiscam_u1$hisco, hiscam_u1$hiscam)], 
       !duplicated(hiscam_u1$hisco)) # keep duplicate hisco's w. smallest value
tables()

write.table(hiscam_unq, 
            file = "./data/derived/hiscam_u1v1_3_unique_hisco.dat",
            row.names = FALSE,
            col.names = TRUE)

setkey(hiscam_unq, hisco)
tables()


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

## this returns a merged dataset, but
## - the object is not put in the workspace
## - it removes the non-merged values

data.table()







