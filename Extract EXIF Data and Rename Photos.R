#A script to pull metadata from a folder of photos, then re-name the photos with the date 

library(dplyr)
library(readr)
library(tidyverse)
library(lubridate)
library(exifr)

#Specify the path to the folder location
path <- paste0("C:/YourPath/","Any-Additional-Info")

#Pull EXIF data from folder specified in your path
dat <- read_exif(path = path, quiet = FALSE, recursive = TRUE, tags = c("GPSLatitude", "GPSLongitude","SourceFile", "DateTimeOriginal"))

#Add Date column
dat2 <- separate(dat, DateTimeOriginal, c("Date","Time"), sep = " ", remove = TRUE, fill = 'right')
dat2$Date <- ymd(dat2$Date)

#Extract the image number from the metadata -- this will be used in labeling
dat2a <- dat2 %>%
  separate(SourceFile, c("P1", "P2", "P3", "P4"), sep = "/", remove = FALSE, fill = 'right') %>%
  separate(P4, c("IMG", "Num"), sep = "_", remove = FALSE, fill = 'right')

#Join and select desired data
dat2 <- right_join(dat2, dat2a) %>%
  select_if(names(.) %in% (c("SourceFile", "Num", "DateTimeOriginal", "Date","Time", "GPSLatitude", "GPSLongitude")))

filename <- paste0(substr(dat2$Date,1,7),"_","EXIF", ".csv")

#Write metadata file to CSV
write.csv(dat2, paste0("Output/",filename[1]),
          row.names = F)

#Rename files with date and number, as long as files are in same order                 
old_files <- list.files(path = path, full.names = TRUE)

new_files <- paste0(path,"/",dat2$Date, "_", dat2$Num)

file.copy(from = old_files, to = new_files)
file.remove(old_files)

