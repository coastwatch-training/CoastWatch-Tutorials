# Function to check if pkgs are installed, install missing pkgs, and load all required pkgs.
pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop(x, " :Package not found")
  }
}

# create list of required packages
list.of.packages <- c("ncdf4", "httr","plyr","lubridate", "parsedate", "rerddap","plotdap",
                      "rerddapXtracto", "graphics", "maps", "mapdata","RColorBrewer",
                      "ggplot2","scales","dplyr","utils","Rcurl","raster","colorRamps",
                      "parsedate","sp","sf","reshape2","jsonlite","rgdal",
                      "gridGraphics","grid","PBSmapping","date","viridis",
                      "openair","cmocean")

# create list of installed packages
pkges = installed.packages()[,"Package"]

# Install and load all required pkgs
for (pk in list.of.packages) {
  pkgTest(pk)
}

# test that rerddapXtracto is working properly 

dataInfo <- rerddap::info('erdHadISST')

parameter <- 'sst'
xcoord <- c(-120.5, -125.5)
ycoord <- c(30.5, 40.5)
tcoord <- c('2006-01-16', '2006-04-16')
extract <- rxtracto_3D(dataInfo, parameter, xcoord = xcoord, ycoord = ycoord,
                       tcoord = tcoord)
str(extract)

# Running > str(extract) should produce the following: 
#   List of 6
# $ sst        : num [1:6, 1:11, 1:4] 17 16.7 16.5 16.2 16.1 ...
# $ datasetname: chr "erdHadISST"
# $ longitude  : num [1:6(1d)] -126 -124 -124 -122 -122 ...
# $ latitude   : num [1:11(1d)] 30.5 31.5 32.5 33.5 34.5 35.5 36.5 37.5 38.5 39.5 ...
# $ altitude   : logi NA
# $ time       : POSIXlt[1:4], format: "2006-01-16 12:00:00" "2006-02-15 00:00:00" "2006-03-16 12:00:00" 
#   
