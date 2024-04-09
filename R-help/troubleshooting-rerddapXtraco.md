# Troubleshooting rerddapXtracto

## Help, I’m getting an error using a function in rerddapXtracto!

Unlike most R error messages, the error messages given out by the functions in the rerddapXtracto package actually ARE helpful (Thank you Roy!).  Here are the most common errors encountered when using these functions:

1.  Dataset not found   
2.  Changes in the parameter name  
3.  Calling, or not calling, the altitude dimension 
4.  Coordinates out of bounds 
5.  NAs in passed variables
6.  error in the url call, perhaps a time out
7.  Coordinate name mismatch (actually not a common error!)


Below each of these errors is explained in more detail, showing examples of the resulting error messages.

### 1.  Dataset not found
The rerddapXtracto package uses the info function in the rerddap package to obtain the basic metadata about a dataset. The default erddap used by rerddap::info is  https://upwell.pfeg.noaa.gov/erddap/.  If the dataset ID passed to rerddap::info is not on this erddap then an error will be given as in the example below. 

``` dataInfo <- rerddap::info('hawaii_soest_5687_3d16_a6d4')
Error: 'Error {
    code=404;
    message="Not Found: Currently unknown datasetID=hawaii_soest_5687_3d16_a6d4";
}
```

 does not exist in current working directory ('C:/Users/CaraWilson/Documents').

To fix this error identify the url of the erddap with this dataset in the call.  

```
dataInfo <- rerddap::info('hawaii_soest_5687_3d16_a6d4',
                      url='https://oceanwatch.pifsc.noaa.gov/erddap/')
```

This error can also arise if you have a typo in the datasetID, so make sure that is not the case. Occasionally ERDDAP servers are restarted and when this happens it can take a few hours for the datasets to all get reloaded.  When this is happening you will also encounter this error.  If you are sure you are pointing to the correct ERDDAP, and there are no typos in the call, wait a few hours and see if the error gets resolved.  

### 2.  Changes in the parameter name  
There are multiple variations of variable names for chlorophyll (chl, chla, chlor_a, etc,) and temperature (sst, sea_surface_temperature, CRW_SST, etc.) among the most commonly used datasets, so if you change datasets you will probably also have to change the parameter name. 

Below is an example of making a call with an erroneous parameter name. Here the parameter name is passed as “chl’”, but the actual parameter name for this dataset is “chla”. As seen below this information is clearly given in the error message:   

```
dataInfo <- rerddap::info('erdVHNchlamday')
parameter <- 'chl'
chlVIIRS < -rxtracto_3D(dataInfo, parameter=parameter,
tcoord=c("2021-01-15",”2021-03-15”),
xcoord=c(-170,-160),
				ycoord=c(10,20),
				zcoord=c(0,0))
Parameter given is not in dataset
Parameter given:  chl
Dataset Parameters:  chla

[1] "Execution halted"
```

So to fix this error, rerun the command after redefining the parameter name as parameter <- ’chla’. The metadata returned by the rerddap info call, which is read into the dataInfo variable in the CoastWatch scripts, lists all the parameter names. You can also directly extract this information out of the dataInfo variable:  

```
parameter <- dataInfo$variable$variable_name
```

Keep in mind that if the chosen dataset has more than one variable the line above  would have to be amended. 

### 3.  Calling, or not calling, the altitude dimension 
Some datasets have an altitude dimension, although most do not.  If the dataset has an altitude dimension it must be given in the call (even though one usually just passes an empty vector).  If the requested dataset does not have altitude then it must not be passed in the request.  

In the example below a call is made which didn’t pass the altitude dimension, but the dataset being used has this dimension, causing an error: 

```
dataInfo <- rerddap::info('erdVHNchlamday')
parameter <- 'chla'
chlVIIRS<-rxtracto_3D(dataInfo,parameter=parameter,
tcoord=c("2021-01-15",2021-03-15”),
xcoord=c(-170,-160),
				ycoord=c(10,20))

[1] "Ranges not given for all of the dataset dimensions"
[1] "Coordinates given: "
[1] "longitude"  "latitude"  "time"     
[1] "Dataset Coordinates: "
[1] "time"   "altitude"  "latitude"  "longitude"
[1] "Execution halted"
```
To fix this error add “zcoord=c(0,0)” to the call.  If you are using a dataset with an altitude dimension the data returned will be in 4 dimensions, as can be seen in this example: 

```
> dim(chlVIIRS$chla)
[1] 1334 1334    1    3
```
The CoastWatch scripts are set up to work with returned data with only 3 dimensions. So the extraneous 4th dimension should be dropped: 

```
> chlVIIRS$chla <- drop(chlVIIRS$chla)
> dim(chlVIIRS$chla)
[1] 1334 1334    3
```
In the example below a call is made which passes the altitude dimension, but the dataset being used doesn’t have this dimension, causing an error: 

```
dataInfo <- rerddap::info('erdMH1chlamday')
parameter <- dataInfo$variable$variable_name
chlMODIS <- rxtracto_3D(dataInfo,parameter=parameter,
                      tcoord=c("2021-01-15","2021-03-15"),
                      xcoord=c(-170,-160),
                      ycoord=c(10,20),
                      zcoord=c(0,0))


[1] "Requested coordinate names do no match dataset coordinate names"
[1] "Requested coordinate names: longitude"
[2] "Requested coordinate names: latitude" 
[3] "Requested coordinate names: altitude" 
[4] "Requested coordinate names: time"     
[1] "Dataset coordinate names: time"     
[2] "Dataset coordinate names: latitude" 
[3] "Dataset coordinate names: longitude"
```

To fix this error remove the “zcoord=c(0,0)” from the call. 

### 4.  Coordinates out of bounds 
Asking for dates outside of the timespan of a dataset is the most common example of the ‘coordinates out of bounds’ error, but it can also happen for latitude and longitude if you are not using a global dataset. The example below requests satellite data for times that are not within the temporal span of the satellite dataset. The error message says there is a problem with the bounds of the time dimension, and lists the bounds requested, and the bounds of the dataset. Data was requested for Feb 2015 but the dataset only starts in March 2015.  

```
dataInfo <- rerddap::info('erdVHNchlamday')
chlVIIRS<-rxtracto_3D(dataInfo, parameter='chla',
                      tcoord=c("2015-02-15","2016-04-15"),
                      xcoord=c(-170,-160),
                      ycoord=c(10,20),zcoord=c(0,0))
[1] "dimension name: time"
[1] "given coordinate bounds 2015-02-15 2016-04-15"
[1] "ERDDAP datasets bounds 2015-03-16 2021-12-16 12:00:00"
[1] "Coordinates out of dataset bounds - see messages above"
```

To fix this problem change the time request so that it is within the bounds of the satellite dataset.  Remember, you can always determine the bounds by looking at the dataset metadata returned from the rerddap info call (contained in the variable dataInfo in the Coastwatch scripts). You can also encounter this error if you forget to put quotes around the dates that are passed to tcoord. 

### 5. NAs in passed variables
If there are any NAs in the passed vectors of latitude, longitude or time then the functions will fail. This error will occur most often when using the rxtracto function. Here’s an example.

```
dataInfo <- rerddap::info('erdMH1chla1day')
parameter <- dataInfo$variable$variable_name
```

Make up some data with a missing datapoint: 

```
> lon <- c(-180, -170, -160, -150, -140, NA, -130, -120)
> lat <- c(31, 31.2, 33.2, 34, 33, 34, 32, 31)
> time <- rep("2020-09-13", length(lon)) 

> tagchl <- rxtracto(dataInfo, parameter=parameter,
                  xcoord=lon, ycoord=lat,
                  tcoord=time, xlen=.1, ylen=.1)
Error in if ((temp_coord1 < 180) && (temp_coord2 > 180)) { :            0s
  missing value where TRUE/FALSE needed
```

This error is a little more obscure than the others we have been seeing but it is saying that one of the coordinate values is outside of the bounds. Given that the valid bound is listed as 180, we can assume this is an error with the longitude dimension. With our made-up dataset of only 8 points, it is obvious that the problem is with a longitude value, but if you are reading in a dataset with 1000s of points it might not be so easy to determine where the bad points are. The easiest way to deal with this is to consolidate the variables together in a dataframe and omit any NA values.  

```
> tagdata <- data.frame(lon=lon, lat=lat, time=time)
> good_tagdata <- na.omit(tagdata)
```

Then run the extraction with the dataset without any NA values.  

```
> tagchl <- rxtracto(dataInfo, parameter=parameter,
                  xcoord=good_tagdata$lon, ycoord=good_tagdata$lat,
                  tcoord=good_tagdata$time, xlen=.1, ylen=.1)
```

Another common error that can occur when running rxtracto is requesting data for time values that are not within the dataset bounds (see error example #4). In this case you would want to subset your data to remove any points not within the temporal span of the dataset being used.  

### 6. Error in the url call, perhaps a time out
This example is a little harder to troubleshoot.  Here’s an example trying to request a 3D block of MUR SST data.

```
> dataInfo <- rerddap::info('erdMH1chla1day')
> parameter <- dataInfo$variable$variable_name

> sstMUR<-rxtracto_3D(dataInfo,
                      parameter=parameter,
                      tcoord=c("2002-06-02","last"),
                     xcoord=c(-140,-130),
                     ycoord=c(50,60))
 0s 0s[1] "error in trying to download the subset"                                                                    
[1] "check your settings"
$x
<ERDDAP info> jplMURSST41 
 Base URL: https://upwell.pfeg.noaa.gov/erddap 
 Dataset Type: griddap 
 Dimensions (range):  
     time: (2002-06-01T09:00:00Z, 2022-01-30T09:00:00Z) 
     latitude: (-89.99, 89.99) 
     longitude: (-179.99, 180.0) 
 Variables:  
     analysed_sst: 
         Units: degree_C 
     analysis_error: 
         Units: degree_C 
     mask: 
     sea_ice_fraction: 
         Units: 1 

$longitude
[1] -140 -130

$latitude
[1] 50 60

$time
[1] "2002-06-02T09:00:00Z" "2022-01-30T09:00:00Z"

$fields
[1] "analysed_sst"

$read
[1] FALSE

[1] "stopping execution  - will return what has been downloaded so far"
[1] "There was an error in the url call, perhaps a time out. See message on screen and URL called"

The error message here is less specific.  It has returned the coordinates which were requested and the dimensions of the dataset and they seem consistent.  We can get more information by redoing the call with the verbose option on, by adding “verbose=TRUE” in the command.  

> sstMUR<-rxtracto_3D(dataInfo,
                      parameter=parameter,
                      tcoord=c("2002-06-02","last"),
                     xcoord=c(-140,-130),
                     ycoord=c(50,60), verbose=T)
```


The final part of the error message will look the same, but scroll up to the start of the error message and you can find the exact url that was executed by this command, in this case it is: 

```
> GET /erddap/griddap/jplMURSST41.nc?analysed_sst[(2002-06-02T09:00:00Z):1:(2022-01-30T09:00:00Z)][(50):1:(60)][(-140):1:(-130)] HTTP/1.1
Host: upwell.pfeg.noaa.gov
```

Generate the full url by appending the host url to the start of the data request, ie: 

```upwell.pfeg.noaa.gov/erddap/griddap/jplMURSST41.nc?analysed_sst[(2002-06-02T09:00:00Z):1:(2022-01-30T09:00:00Z)][(50):1:(60)][(-140):1:(-130)]```

Paste that url into an internet browser window.  By doing this you are directly asking ERDDAP the same data request made by that call. Doing so returns the following error from ERDDAP: 

```
Error {
    code=413;
    message="Payload Too Large: Your query produced too much data.  Try to request less data. [memory]  54896 MB is more than the .nc 2 GB limit.";
}
```

So the problem is that this request is asking for way too much data!  This is a common error when using the MUR dataset. The spatial resolution of this dataset is 1 km, one of the highest resolution datasets that we serve.  In this case the request is asking for the entire dataset, 20 years of data, at a daily resolution, for a 10 x 10 degree box. This is a lot of data! There are multiple ways to address this error: 

1. Rethink what temporal resolution is needed.  Daily data is overkill when looking for trends or anomalies in 20 years of data, and the monthly dataset would be a much more appropriate choice to use. Using a monthly dataset instead would reduce the data request by more than an order of magnitude.  
2.  Is a 1 km resolution dataset really needed for this exercise, or could a dataset with a coarser resolution be adequate?
3. If a data request larger than the 2 GB limit is truly necessary, split the data request into smaller chunks, and then stitch the data back together in R. Ie, get data one year at a time.  

### 7. Coordinate name mismatch 
This error is actually quite rare.  Some datasets have an altitude dimension that is not called altitude, which is the default name for this dimension. In this case the name of the altitude dimension has to be defined by using the zName parameter in the function call.  If that isn’t done the error message looks like this: 

```
> dataInfo <- rerddap::info('ncdcOisst21Agg')
> sst <-rxtracto_3D(dataInfo, parameter='sst',
+                       tcoord=c("2021-01-15","2021-03-15"),
+                       xcoord=c(170,160),
+                       ycoord=c(10,20),
+                       zcoord=c(0,0))
[1] "Requested coordinate names do no match dataset coordinate names"
[1] "Requested coordinate names: longitude"
[2] "Requested coordinate names: latitude" 
[3] "Requested coordinate names: altitude" 
[4] "Requested coordinate names: time"     
[1] "Dataset coordinate names: time"     
[2] "Dataset coordinate names: zlev"     
[3] "Dataset coordinate names: latitude" 
[4] "Dataset coordinate names: longitude"
```

The error message lists the coordinate names of the datasets and the names of the requested coordinate and there is a mismatch for one of them.  The dataset has a coordinate of 'zlev' but the coordinate name requested was ‘altitude’, which is the default name for this dimension. Inserting "zName = 'zlev'" in the rxtracto_3D call will eliminate this error.

