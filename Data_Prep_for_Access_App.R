library(exifr)
#NOTE: must have exiftool installed

library(dplyr)
library(leaflet)
library(readr)
library(RColorBrewer)
library(mapview)
library(sf)
library(leafpop)
library(tidyverse)
library(lubridate)

path <- "Photos/"
projcrs <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

# #Pull EXIF data from path

dat <- read_exif(path = path, quiet = FALSE, recursive = TRUE, tags = c("GPSLatitude", "GPSLongitude","SourceFile", "DateTimeOriginal"))

dat2 <- select(dat,
               SourceFile, DateTimeOriginal,
               GPSLongitude, GPSLatitude) %>%
  separate(2, "Date", sep = " ", remove = FALSE, fill = 'right') %>%
  filter(!is.na(GPSLongitude) | !is.na(GPSLatitude)) %>%
  mutate(Date = ymd(Date))

write.csv(dat2, paste0("Output/ExifData - ", Sys.Date(), ".csv"),
          row.names = F)

# dat2 <- read.csv('Data/Exifdata.csv') %>%
#   mutate(Date = ymd(Date))

dat3 <- st_as_sf(x = dat2,
                 coords = c("GPSLongitude","GPSLatitude"),
                 crs = projcrs,
                 na.fail = TRUE) %>%
  select(SourceFile, Date)

#Attempt at mapping photos -- all come out as landscape, though

pal <- colorNumeric(
  palette = "plasma",
  domain = dat3$Date
)


MapDate <- leaflet(dat3) %>%
  addTiles() %>%
  addCircleMarkers(popup = popupImage(dat3$SourceFile, src = "local"),
                   label = ~as.character(SourceFile),
                   color = ~pal(Date),
                   group = "dat3")


MapDate
