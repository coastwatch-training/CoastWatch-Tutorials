# Combining two NetCDF files at the antimeridian

> File Name: combining_netcdf_antimeridian.md  
> Date Created: Mar 2019  
> Owner: CoastWatch  
> Author: Dale Robinson, CoastWatch West Coast Node  

This example shows how to merge two NetCDF files that span the antimeridian into one NetCDF file. This is a common task when working with satellite data in the polar regions. Here we will demonstrate downloading ice concentration from ERDDAP in two sections and then show how to piece them together into one file. This is accomplished with the easy to use NetCDF Operator Tools which are command line programs for working with NetCDF files. 

Learn more about NCO and download the package at: http://nco.sourceforge.net/nco.html#Summary

## Download the data in NetCDF Format

Will will download data from ERDDAP from Longitudes 176 to -152. To do this we will download two files, one from 176 to 180, and another from -180 to -152.

### Western Pacific File Download

* Longitude Range: 176 to 180, and Latitude Range: 50 to 89.99
* The ERDDAP URL for the file download:  
http://coastwatch.pfeg.noaa.gov/erddap/griddap/jplMURSST41.nc?sea_ice_fraction[(2018-02-04T09:00:00Z):1:(2018-02-04T09:00:00Z)][(50):1:(89.99)][(176):1:(180.0)]
* Rename the downloaded file to **Wpacific.nc**

### Eastern Pacific File Download
* Longitude Range: -179.99 to -152, and Latitude Range: 50 to 89.99
* The ERDDAP URL for the file download:  
http://coastwatch.pfeg.noaa.gov/erddap/griddap/jplMURSST41.nc?sea_ice_fraction[(2018-02-04T09:00:00Z):1:(2018-02-04T09:00:00Z)][(50):1:(89.99)][(-179.99):1:(-152)]
* Rename the downloaded file to **Epacific.nc**

## Change the record dimension from Time to Longitude

Temporarily change the record dimension from `time` to `longitude` in the two files. 
The resulting files are named with a "L" ending, which indicates the files use the longitude dimension and makes it easier to follow the work flow.

```
ncpdq -O -a longitude,time Wpacific.nc Wpacific_L.nc
ncks -O --mk_rec_dmn longitude Wpacific_L.nc Wpacific_L2.nc
ncpdq -O -a longitude,time Epacific.nc Epacific_L.nc
ncks -O --mk_rec_dmn longitude Epacific_L.nc Epacific_L2.nc
```

## Remove references to longitude extent

Remove the `valid_min` and `valid_max` from the longitude variable in both files

```
ncatted -O -a valid_min,longitude,d,f, Wpacific_L2.nc
ncatted -O -a valid_max,longitude,d,f, Wpacific_L2.nc
ncatted -O -a valid_min,longitude,d,f, Epacific_L2.nc
ncatted -O -a valid_max,longitude,d,f, Epacific_L2.nc
```

## Shift the longitude range

Use `ncap2` to shift the Eastern Pacific (western hemisphere) longitudes into the range 180 - 360

```
ncap2 -s "longitude= longitude+360.0f" Epacific_L2.nc Epacific360.nc
```

## Combine the files

Concatenate the Western and Eastern Pacific files along new (longitude) record dimension, naming the resulting file **combined_pacific360.nc**

```
ncrcat Wpacific_L2.nc Epacific360.nc combined_pacific360.nc
```

## Update the dimensions

Change the record dimension back to "time" in the **combined_pacific360.nc** file

```
ncpdq -O -a time,longitude combined_pacific360.nc combined_pacific360b.nc
ncks -O --mk_rec_dmn time combined_pacific360b.nc combined_pacific360b.nc
```

## Set the Max and Min Ranges

Restore the `valid min` and `valid_max` attributes of the longitude variable in the **combined_pacific360.nc** file, making them 0 and 360, respectively (optional) and delete the old `actual_range` (optional)

```
ncatted -O -a valid_min,longitude,c,f,0.0 combined_pacific360b.nc
ncatted -O -a valid_max,longitude,c,f,360.0 combined_pacific360b.nc
ncatted -O -a actual_range,longitude,d,, combined_pacific360b.nc
```

## Clean Up

Optionally, remove the original and intermediary files.

```
rm Epacific_L.nc Epacific_L2.nc Epacific.nc Epacific360.nc Wpacific_L.nc Wpacific_L2.nc Wpacific.nc combined_pacific360.nc
```
