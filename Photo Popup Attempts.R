library(exifr)
library(dplyr)
library(leaflet)
library(readr)
library(RColorBrewer)
library(mapview)
library(sf)
library(leafpop)


#This doesn't work at all
img = "http://bit.ly/1TVwRiR"
img2 = "dat3$SourceFile"
img3 = "C:/Users/Austin Paralegal/Desktop/me.jpg"

#Several attempts at mapping:

#1 with mapview and popup = 

mapview(datB3,
        popup = popupImage(dat2$SourceFile, src = "local"))

mapview(datB3,
        popup = popupImage())


#2 with leaflet and addPopupImages 
#(this gets us close, but images are still distorted and way too big)
leaflet(datB3) %>%
  addTiles() %>%
  addCircleMarkers(label = datB3$SourceFile, group = "datB3") %>%
  addPopupImages(datB3$SourceFile, group = "datB3", width = 100, height = 100)

leaflet(datB3) %>%
  addTiles() %>%
  addCircleMarkers(group = "datB3") %>%
  addPopupImages(img, group = "datB3")
#no pop up at all 

leaflet(datB3) %>%
  addTiles() %>%
  addCircleMarkers(group = "datB3") %>%
  addPopupImages(img3, group = "datB3")
#no pop up at all 


#3 with leaflet (my original attempt)
leaflet(datB2) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addCircleMarkers(lng = ~GPSLongitude, lat = ~GPSLatitude,
             popup = popupImage(as.character(datB2$SourceFile), src = "local"),
             options = markerOptions(opacity = 0.9, draggable = T))

#tried with leaflet and a different local image - this worked! which means it must be something with the images themselves
leaflet(datB2) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addCircleMarkers(lng = ~GPSLongitude, lat = ~GPSLatitude,
                   popup = popupImage("C:/Users/Austin Paralegal/Desktop/me.JPG", src = "local"),
                   options = markerOptions(opacity = 0.9, draggable = T))