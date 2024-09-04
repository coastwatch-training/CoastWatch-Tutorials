## CoastWatch-Tutorials

Each tutorial module is designed to illustrate the process of accessing and manipulating satellite data from the CoastWatch ERDDAP data servers. In addition to this, the modules incorporate commonly employed data wrangling techniques and tasks as exemplars. 

It should be noted that the module content is intended strictly for educational and demonstrative purposes. Any code samples provided should be regarded as examples and be reviewed if adapted for research or operational objectives.

### Repository Organization
The repository is structured into directories, categorized by specific topics. Within each topic, directories for different programming languages, like R and Python, can be found. Note that the organization might vary between topics due to the inclusion of additional resources.


### Tutorial Module Descriptions

* [ERDDAP-basics](ERDDAP-basics)
An introduction to what ERDDAP is and an overview of the different CoastWatch ERDDAP servers.  Learn how to visualize and download data from ERDDAP, and how to interpret an ERDDAP url.
* [netcdf-and-panoply-tutorial](netcdf-and-panoply-tutorial)
Learn how to use NASA's Panoply software to open and view netCDF data 
* [Tutorial1-basics](Tutorial1-basics) 
Learn to access satellite data from CoastWatch ERDDAP data server and to work with NetCDF files.  Visualize sea surface temperature on a map and plot time series data.
* [Tutorial2-timeseries-compare-sensors](Tutorial2-timeseries-compare-sensors)
Learn common ways to download data from ERDDAP servers to access time-series chlorophyll data from four different satellite datasets and summarize and visualize the data for comparison.
* [calculate-seaice-extent](calculate-seaice-extent)
View sea ice concentration (SIC) data on a map with the polar stereographic projection.  Calculate and compare sea ice area/extent from multi-year SIC datasets.
* [convert-180+180-to-0-360-longitude](convert-180+180-to-0-360-longitude)
Work with datasets with -180&deg; to +180&deg; longitude values in a region that crosses the antimeridian.  Convert the coordinates from (-180, +180) to (0, 360)  and visualize data on a map.
* [create-virtual-buoy-with-satellite-data](create-virtual-buoy-with-satellite-data)
  Create a “virtual” buoy using satellite data to fill the gaps in in-situ data collected by a physical buoy. Extract data from a location close to an existing buoy.  Clean dataset by removing outliers, and aggregate (resample) to achieve a reduced temporal resolution.  Plot time series data.
* [extract-satellite-data-within-boundary](extract-satellite-data-within-boundary)
  Extract sea surface temperature satellite data for an non-rectangular geographical region from an ERDDAP server using a shapefile, make maps, and plot a timeseries of the seasonal cycle of SST within the boundary.
* [map-data-with-different-projections](map-data-with-different-projections)
Download and examine a polar stereographic projected dataset, plot the data on a projected map.  Add animal track data with geographical coordinates onto the projected map.
* [matchup-satellite-buoy-data](matchup-satellite-buoy-data)
  Temporally and geospatially subset satellite data to match with buoy data (tabular), run statistical analysis and produce a map of the satellite data with overlaying buoy data.
* [matchup-satellite-data-to-track-locations](matchup-satellite-data-to-track-locations)
  Extract satellite data along a set of points defined by longitude, latitude, and time coordinates like that produced by an animal telemetry tag, a ship track, or a glider track.
* [transform-to-another-map-projection](transform-to-another-map-projection)
  	Access satellite data with polar stereographic coordinates and transform it into a different coordinate system using EPSG code.
* [calculate-departures-and-trends-from-timeseries-polar-data](calculate-departures-and-trends-from-timeseries-polar-data)

* [calculate-climatology-with-polar-data](calculate-departures-and-trends-from-timeseries-polar-data)

* [subset-polar-data-with-shapefile]([subset-polar-data-with-shapefile)

* [matchup-polar-data-to-animal-track-locations](matchup-seaice-data-to-animal-track-locations)

* [matchup-polar-data-to-buoy-data](matchup-polar-data-to-buoy-data)

### Acknowledgement

The training materials for the CoastWatch Program have been developed, reviewed, and edited with the contributions of many dedicated individuals:

- Melanie Abecassis 
- Peter Hollemans 
- Sun Bak Hospital 
- Roy Mendelssohn 
- Dale Robinson 
- Jennifer Sevadjian 
- Hui (Daisy) Shi  
- Michael Soracco  
- Shelly Tomlinson
- Ron Vogel
- Victoria Wegman  
- Cara Wilson  

We also extend our gratitude to other external contributors whose specific acknowledgements are included within the training materials they helped to create.
### Questions?

If you need any further assistance, questions or error reporting, please submit an issue on github.


