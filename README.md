## CoastWatch-Tutorials

Each tutorial module is designed to illustrate the process of accessing and manipulating satellite data from the CoastWatch ERDDAP data servers. In addition to this, the modules incorporate commonly employed data wrangling techniques and tasks as exemplars. 

It should be noted that the module content is intended strictly for educational and demonstrative purposes. Any code samples provided should be regarded as examples and be reviewed if adapted for research or operational objectives.

### Repository Organization
The repository is structured into directories, categorized by specific topics. Within each topic, directories for different programming languages, like R and Python, can be found. Note that the organization might vary between topics due to the inclusion of additional resources


### Tutorial Module Descriptions

* [Tutorial1-basics](Tutorial1-basics) 
Learn to access satellite data from CoastWatch ERDDAP data server and to work with data in NetCDF files to make maps and time series of sea surface temperature
* [Tutorial2-timeseries-compare-sensors](Tutorial2-timeseries-compare-sensors)
Access time-series chlorophyll data from four different satellite datasets and summarize and visualize the data for comparison
* [calculate-seaice-extent](calculate-seaice-extent)
View sea ice concentration (SIC) data on a map with the polar stereographic projection.  Calculate and compare sea ice area/extent from multi-year SIC datasets
* [convert-180+180-to-0-360-longitude](convert-180+180-to-0-360-longitude)
Work with datasets with -180&deg; to +180&deg; longitude values in a region that crosses the antimeridian.  Convert the coordinates from (-180, +180) to (0, 360)  and visualize data on a map
* [create-virtual-buoy-with-satellite-data](create-virtual-buoy-with-satellite-data)
  Create a “virtual” buoy using satellite data, aligning closely with the spatial and temporal coverage of an existing buoy.  Clean dataset by removing outliers, and aggregate (resample) to achieve a reduced temporal resolution.  Construct a time series plot to visualize the data.
* [define-marine-habitat](define-marine-habitat)
* [extract-satellite-data-within-boundary](extract-satellite-data-within-boundary)
  Download a timeseries of SST satellite data from ERDDAP server, mask the data within an irregular geographical boundary using a shape file, and plot a seasonal cycle within the boundary
* [map-data-with-different-projections](map-data-with-different-projections)
* [matchup-satellite-buoy-data](matchup-satellite-buoy-data)
  Temporally and geospatially subset satellite data to match with buoy data (tabular), run statistical analysis and produce satellite map with overlaying buoy data
* [matchup-satellite-data-to-track-locations](matchup-satellite-data-to-track-locations)
  Extract satellite data around a set of points defined by longitude, latitude, and time coordinates like that produced by an animal telemetry tag, a ship track, or a glider tract.
* [py-xtractomatic](py-xtractomatic) **need update**
* [reprojecting-satellite-buoy-data](reprojecting-satellite-buoy-data) **need update**
* [transform-to-another-map-projection](transform-to-another-map-projection)
  	Access satellite data with polar stereographic coordinates and transform them into a different coordinate system using EPSG code
* [work-with-projected-datasets](work-with-projected-datasets) **need  update**

  

### Questions?

If you need any further assistance, questions or error reporting, please submit an issue on github.


