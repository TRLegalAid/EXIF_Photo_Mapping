# EXIF_Photo_Mapping
scripts and shiny apps for managing photo metadata and plotting image locations on map.

This was developed for a case where a client had a large amount of photo evidence. Advocates wanted to sort through the photos by date and location. Later, they wanted to document each photo's metadata and rename each file for the date. 

See deployed shiny app [here](https://trla.shinyapps.io/EXIF_Photo_Mapping/).

Need: 

* [exiftool](https://exiftool.org/)
* add an empty folder called "Output"
* add an empty folder called "Photos"
* add an empty folder called "Data"
* put custom photos in your Photos folder

## what's in this repo

### Data_Prep_for_Access_App

This file pulls the metadata from a folder of files and prepares the dataset to be plotted on a map.

### Extract EXIF Data and Rename Photos

This file pulls the metadata from a folder of files and renames all the photos for the date on which they were taken.

### Photo Popup Attempts

This file documents varied attempts to get the photos themselves to show up in the map pop-up. All photos were displayed as landscape, when they were vertical images. 

### Photo_Access_App

This is the Shiny App that displays the photo locations on a map and allows a person to filter by date.

## to-do

* allow user to upload their own photos! see [here](https://shiny.rstudio.com/articles/upload.html)
* display photos in pop-up
* add download button for the table
