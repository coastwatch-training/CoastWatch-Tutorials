## CoastWatch-Tutorials 

[![DOI](https://zenodo.org/badge/687659653.svg)](https://doi.org/10.5281/zenodo.14225894)

Each tutorial module is designed to illustrate the process of accessing and manipulating satellite data from the CoastWatch ERDDAP data servers. In addition to this, the modules incorporate commonly employed data wrangling techniques and tasks as exemplars. 

It should be noted that the module content is intended strictly for educational and demonstrative purposes. Any code samples provided should be regarded as examples and be reviewed if adapted for research or operational objectives.

### Repository Organization
The repository is structured into directories, categorized by specific topics. Within each topic, directories for different programming languages, like R and Python, can be found. Note that the organization might vary between topics due to the inclusion of additional resources.


### Tutorial Module Descriptions

* [ERDDAP-basics](ERDDAP-basics)
An introduction to what ERDDAP is and an overview of the different CoastWatch ERDDAP servers.  Learn how to visualize and download data from ERDDAP, and how to interpret an ERDDAP url.
* [netcdf-and-panoply-tutorial](netcdf-and-panoply-tutorial)
Learn how to use NASA's Panoply software to open and view netCDF data. 
* [Tutorial1-basics](Tutorial1-basics) 
Learn to access satellite data from CoastWatch ERDDAP data server and to work with NetCDF files.  Visualize sea surface temperature on a map and plot time series data. R and python versions. 
* [Tutorial2-timeseries-compare-sensors](Tutorial2-timeseries-compare-sensors)
Learn common ways to download data from ERDDAP servers to access time-series chlorophyll data from four different satellite datasets and summarize and visualize the data for comparison. R and python versions. 
* [convert-180+180-to-0-360-longitude](convert-180+180-to-0-360-longitude)
Work with datasets with -180&deg; to +180&deg; longitude values in a region that crosses the antimeridian.  Convert the coordinates from (-180, +180) to (0, 360)  and visualize data on a map. Python only. 
* [create-virtual-buoy-with-satellite-data](create-virtual-buoy-with-satellite-data)
  Create a “virtual” buoy using satellite data to fill the gaps in in-situ data collected by a physical buoy. Extract data from a location close to an existing buoy.  Clean dataset by removing outliers, and aggregate (resample) to achieve a reduced temporal resolution.  Plot time series data. R and python versions. 
* [extract-satellite-data-within-boundary](extract-satellite-data-within-boundary)
  Extract sea surface temperature satellite data for an non-rectangular geographical region from an ERDDAP server using a shapefile, make maps, and plot a timeseries of the seasonal cycle of SST within the boundary. R and python versions. 
* [matchup-satellite-buoy-data](matchup-satellite-buoy-data)
  Temporally and geospatially subset satellite data to match with buoy data (tabular), run statistical analysis and produce a map of the satellite data with overlaying buoy data. R only. 
* [matchup-satellite-data-to-track-locations](matchup-satellite-data-to-track-locations)
  Extract satellite data along a set of points defined by longitude, latitude, and time coordinates like that produced by an animal telemetry tag, a ship track, or a glider track. R and python versions.
  
__PolarWatch Specific Examples__

* [transform-to-another-map-projection](transform-to-another-map-projection)
  	Access satellite data with polar stereographic coordinates and transform it into a different coordinate system using EPSG code. R and python versions. 
* [map-data-with-different-projections](map-data-with-different-projections)
  Download and examine a polar stereographic projected dataset, plot the data on a projected map.  Add animal track data with geographical coordinates onto the projected map. R and python versions. 
* [calculate-seaice-extent](calculate-seaice-extent)
  View sea ice concentration (SIC) data on a map with the polar stereographic projection.  Calculate and compare sea ice area/extent from multi-year SIC datasets. R and python versions. 
* [matchup-polar-satellite-data-to-buoy-data](matchup-polar-satellite-data-to-buoy-data)
   Extract satellite sea ice temperature data in a polar stereographic projection that is col-located with a buoy's location and dates. R and python versions.
* [matchup-polar-data-to-animal-track-locations](matchup-polar-data-to-animal-track-locations)
  Extract sea ice concentration data in polar projection along a set of points defined by longitude, latitude, and time coordinates like that produced by an animal telemetry tag, a ship track, or a glider track.R and python versions.
* [subset-polar-data-with-shapefile](subset-polar-data-with-shapefile)
  Download remote sensing data in polar stereographic projection from ERDDAP and subset it within the boundaries of Lake Iliamna in Alaska, where the lake shape data is presented in a different projection. R and python versions.
* [seaice-thickness-climatology](seaice-thickness-climatology)
  Calculate the long-term monthly mean of sea ice thickness and assess the current sea ice thickness by analyzing anomalies and trends relative to the long-term mean. Python only
* [jpss-seaice-concentration](jpss-projects/sport-jpss-seaice)
  Process L2 or L3 sea ice data and visualize it on a map with a polar stereographic projection. This tutorial is created by [SPoRT](https://weather.ndc.nasa.gov/sport/) and is designed to be run in Google Colab with pre-downloaded data files. Python only.
 

__Great Lakes Specific Examples__

* [gl-access-sat-surface-temp-data](great-lakes-examples/Python/gl-access-sat-surface-temp-data.ipynb)
Access and subset Lake Erie water surface temperature data, and plot both individual time steps and a time series. 
* [gl-timeseries-chloro-from-diff-sensors](great-lakes-examples/Python/gl-timeseries-chloro-from-diff-sensors.ipynb)
Download mean chlorophyll-a concentration data from two sensors, MODIS (2002-2017) and VIIRS (2018-2023), to compare the values.
* [gl-ice-plot-timeseries-ice-conc.ipynb](great-lakes-examples/Python/gl-ice-plot-timeseries-ice-conc.ipynb)
Access Great Lakes ice concentration data from ERDDAP, visualize it on a map, and calculate the monthly means.
* [gl-timeseries-surface-temp.ipynb](great-lakes-examples/Python/gl-timeseries-surface-temp.ipynb)
 Download Great Lakes average water surface temperature and compute a long-term time series (2007-2024), identifying the warmest and coldest years.

__Long Island Sound Specific Examples__
* [lis-chlora-dynamics](long-island-sound-examples)
Download Sentinel-3 OLCI water quality data optimized for Long Island Sound from CoastWatch ERDDAP data server. Visualize
monthly chlorophyll-a in a multi-panel figure and compare chlorophyll-a time series across regions.

### Citation

**Project Name**: CoastWatch Tutorials  
**Author**: NOAA CoastWatch  
**DOI**: 10.5281/zenodo.14225895  
**Version**: v1.0.1  
**URL**: [https://github.com/coastwatch-training/CoastWatch-Tutorials](https://github.com/coastwatch-training/CoastWatch-Tutorials)

### Acknowledgement

The training materials for the CoastWatch Program have been developed, reviewed, and edited with the contributions of many dedicated individuals.

__Contributors__: Melanie Abecassis, Peter Hollemans, Sun Bak Hospital, Songzhi Liu, Roy Mendelssohn, Madison Richardson, Dale Robinson, Jennifer Sevadjian, Jonathan Sherman,  Hui (Daisy) Shi, Michael Soracco, Shelly Tomlinson, Ron Vogel, Victoria Wegman, Cara Wilson  


We also extend our gratitude to other external contributors whose specific acknowledgements are included within the training materials they helped to create.

### Questions?

If you need any further assistance, questions or error reporting, please submit an issue on github.


