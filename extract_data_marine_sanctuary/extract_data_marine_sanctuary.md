> notebook filename \| extract\_data\_marine\_sanctuary.Rmd  
> history \| Created March 2020

# Extract data within a boundary

In this exercise, you will download data from within the boundaries of
the Monterey Bay National Marine Sanctuary (MBNMS) and visualize the
data on a map.

The exercise demonstrates the following skills:

-   Using **rerddap** to retrieve information about a dataset from
    ERDDAP
-   Using the **rxtractogon** function from **rerdapXtracto** to extract
    satellite data within an polygon over time  
-   Mapping satellite data

## Install packages and load libraries

``` r
pkges = installed.packages()[,"Package"]
# Function to check if pkgs are installed, install missing pkgs, and load
pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE,repos='http://cran.us.r-project.org')
    if(!require(x,character.only = TRUE)) stop(x, " :Package not found")
  }
}

# create list of required packages
list.of.packages <- c("ncdf4", "rerddap","plotdap", "parsedate", 
                      "sp", "ggplot2", "RColorBrewer", 
                      "reshape2", "maps", "mapdata", 
                      "jsonlite", "rerddapXtracto")

# Run install and load function
for (pk in list.of.packages) {
  pkgTest(pk)
}

# create list of installed packages
pkges = installed.packages()[,"Package"]
```

## Load sanctuary boundary coordinates

The **rerddapXtracto** package comes with the dataset **mbnms** which
conatains the longitude and latitude values for the boundary of the
Monterey Bay National Marine Sanctuary. These coordinates draw the the
boundary of the sanctuary on a map, like tracing a dot-to-dot drawing.
Take a quick look at the contents of this data variable.

``` r
str(mbnms)
```

    ## 'data.frame':    6666 obs. of  2 variables:
    ##  $ Longitude: num  -123 -123 -123 -123 -123 ...
    ##  $ Latitude : num  37.9 37.9 37.9 37.9 37.9 ...

Additional sanctuary boundaries may be obtained at
<http://sanctuaries.noaa.gov/library/imast_gis.html>.

**The script below:**

-   Extracts the longitude and latitude data into vector variables

``` r
xcoord <- mbnms$Longitude
ycoord <- mbnms$Latitude
```

## Select the chloropyll dataset

For this example we will use a 750 m VIIRS monthly chlorophyll dataset
(ID erdVHNchlamday)

**The script below:**  
\* Gathers information about the dataset (metadata) using **rerddap**  
\* The default source ERDDAP for **rerddap** is
“<https://upwell.pfeg.noaa.gov/erddap>”. Since we are pulling the data
from a different ERDDAP at “<http://coastwatch.pfeg.noaa.gov/erddap/>”,
change the url to url = “<http://coastwatch.pfeg.noaa.gov/erddap/>” \*
Displays the dataset information

``` r
# Use rerddap to get dataset metadata 
url = "http://coastwatch.pfeg.noaa.gov/erddap/"
dataInfo <- rerddap::info('erdVHNchlamday',url=url)  # N. Pacific 750 m VIIRS chl
# Display the metadata dataset info
dataInfo
```

    ## <ERDDAP info> erdVHNchlamday 
    ##  Base URL: http://coastwatch.pfeg.noaa.gov/erddap 
    ##  Dataset Type: griddap 
    ##  Dimensions (range):  
    ##      time: (2015-03-16T00:00:00Z, 2021-11-16T00:00:00Z) 
    ##      altitude: (0.0, 0.0) 
    ##      latitude: (-0.10875, 89.77125) 
    ##      longitude: (-180.03375, -110.00625) 
    ##  Variables:  
    ##      chla: 
    ##          Units: mg m^-3

## Set the options for the polygon data extract

The **rxtractogon** function will need the parameter and coordinates for
the extract \* For the parameter: Use the name of the chlorophyll
parameter that was displayed above in dataInfo: **parameter &lt;-
“chla”** \* For the coordinates: determine your selctions for x, y, z,
and time. \* z coordinate: The metadata from dataInfo shows that this
variable has a altitude coordinate that equals zero. So set the value of
the z coordinate to zero: **zcoord &lt;- 0.**  
\* time coordinate: The time variable passed to xtracogon must contain
two elements, the start and endpoints of the desired time period. This
example uses ERDDAP’s **last** option to retrieve data from the most
recent time step. The **last** option also accepts the minus **-**
operator. To request the time step with the second most recent data use
“last-1”. In the script below the time variable (tcoord) is defined as
**tcoord &lt;- c(“last-1”, “last”)**

``` r
# set the parameter to extract
parameter <- 'chla'
# set the time range
tcoord <- c("last-1", "last")
# Assign longitude and latitude vectors from the CSV file to variables
xcoord <- mbnms$Longitude
ycoord <- mbnms$Latitude
# set the altitude variable to zero
zcoord <- 0. 
```

## Extract data and mask it using rxtractogon

-   Run **rxtractogon** to extract data from the “erdVHNchlamday”
    dataset and mask out any data outside the MBNMS boundary.  
-   List the data

``` r
## Request the data
sanctchl <- rxtractogon (dataInfo, parameter=parameter, xcoord=xcoord, ycoord=ycoord,tcoord=tcoord,zcoord=zcoord)

## List the returned data
str(sanctchl)
```

    ## List of 6
    ##  $ chla       : num [1:272, 1:311, 1:2] NA NA NA NA NA NA NA NA NA NA ...
    ##  $ datasetname: chr "erdVHNchlamday"
    ##  $ longitude  : num [1:272(1d)] -123 -123 -123 -123 -123 ...
    ##  $ latitude   : num [1:311(1d)] 35.6 35.6 35.6 35.6 35.6 ...
    ##  $ altitude   : num [1(1d)] 0
    ##  $ time       : POSIXlt[1:2], format: "2021-10-16 12:00:00" "2021-11-16 00:00:00"
    ##  - attr(*, "class")= chr [1:2] "list" "rxtracto3D"

## Choose Time to Plot

The extracted data contains two time periods of chlorophyll data within
the sanctuary boundaries. For this example we will show how to select
just one time period from the options and map it, here we choose the
second time stamp.

``` r
sanctchl1 <- sanctchl
sanctchl1$chla <- sanctchl1$chla[, , 2]
sanctchl1$time <- sanctchl1$time[2]
```

### Plot the data

-   Use the plotBBox function in rerddapXtracto to quickly plot the data

``` r
plotBBox(sanctchl1, plotColor = 'algae',maxpixels=100000)
```

    ## Warning in raster::projectRaster(r, crs = crs_string): input and ouput crs are
    ## the same

![](extract_data_marine_sanctuary_files/figure-gfm/map-1.png)<!-- -->

### Apply a function to the data

-   Here we apply a log function to the chlorophyll data and plot it
    again.

``` r
myFunc <- function(x) log(x) 
plotBBox(sanctchl1, plotColor = 'algae',maxpixels=100000, myFunc=myFunc)
```

    ## Warning in raster::projectRaster(r, crs = crs_string): input and ouput crs are
    ## the same

![](extract_data_marine_sanctuary_files/figure-gfm/addfunc-1.png)<!-- -->
