## Code-Modules

Each module is designed to illustrate the process of accessing and manipulating satellite data from the CoastWatch ERDDAP data servers. In addition to this, the modules incorporate commonly employed data wrangling techniques and tasks as exemplars. 

It should be noted that the module content is intended strictly for educational and demonstrative purposes. Any code samples provided should be regarded as examples and be reviewed if adapted for research or operational objectives.

### Repository Organization
The repository is structured into directories, categorized by specific topics. Within each topic, directories for different programming languages, like R and Python, can be found. Note that the organization might vary between topics due to the inclusion of additional resources


### Module content

* [calculate-seaice-extent](calculate-seaice-extent) 
Calculate the sea ice area and extent, visulaize data, and plot a time series of sea ice area of North Polar region
* [compare-sensor-data] 

* [extract-satellite-data-within-boundary]
Access sea sirface temperature data from ERDDAP and visualize data on a map.  For R, you will use **rerddap** and **rxtractogon** to access and plot data
* [map-data-with-different-projection]
Plot two datasets on a polar stereographic projected map: first to map sea ice concentration data in polar stereographic coordiantes and to add animal track location data in latitude and longitude. 

* [matchup-satellite-buoy-data]
Subset satellite data within a polygon, match satellite data with buoy data, perform statistical analysis, Visualize satellite and buoy data on a map
* [matchup-satellite-data-to-track-locations]
Plot track locations data on a map, extract satellite data along a track, merge satellite and track data into one dataset, plot two datasets on a map
* [nco-antimeridian-combine-netcdf]

* [py-xtractomatic]
Work with accessing csv and netCDF files from remote servers and CoastWatch ERDDAP data server. 
* [reprojecting-satellite-buoy-data]
* [transform-coord-from-crs-to-crs]
* [virtual-buoy-example-geopolar]
* [work-with-projected-datasets]
* [work-with-timeseries-satellite-data]



* [Matchups satellite data to an animal tracks](matchup_satellite_track_data.md)  
This exercise you will extract satellite data around a set of points defined by longitude, latitude, and time coordinates like that produced by an animal telemetry tag, a ship track, or a glider tract.  

* [Create timeseries from satellite data](timeseries_satellite_data.md)  
This excercise extracts a time series of monthly satellite chlorophyll data for the period of 1997-present from four different monthly satellite datasets.  


### Questions?

If you need any further assistance, questions or error reporting, please submit an issue on github.


