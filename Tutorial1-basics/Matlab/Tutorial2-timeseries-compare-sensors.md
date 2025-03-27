## Tutorial 2. Comparison of chlorophyll data from different sensors
As an example, we are going to plot time-series of mean chlorophyll-a concentration from various sensors from 1997 to 2018 to look at the periods of overlap. 

We are going to download data from SeaWiFS (1997-2010), MODIS (2002-present) and VIIRS (2012-present) and compare it to the ESA-CCI data which combines all 3 sensors into a homogeneous time-series.  
In this tutorial, the URLs to the data are provided so you don't have to search for them.  But, if you weren't sure what the URLs were, you could find them by searing the list of datasets hosted on the OceanWatch ERDDAP (https://oceanwatch.pifsc.noaa.gov/erddap/index.html) and following the steps at the beginning of Tutoral 1. 

**For this tutoral, we're interested in all time steps in the area bounded by 15 - 25N, 198 - 208E.**

### Get monthly SeaWiFS data, which starts in 1997
In Matlab, run the following code to view details about the data:

```matlab
% View data attributes and variables
ncdisp('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/sw_chla_monthly_2018_0');
```
<div style="height: 200px; overflow-y: auto; border: 1px solid #ccc; padding: 10px;">
<pre><code>
Source:
           https://oceanwatch.pifsc.noaa.gov/erddap/griddap/sw_chla_monthly_2018_0
Format:
           classic
Global Attributes:
           _lastModified                    = '2018-01-31T04:58:26.000Z'
           _NCProperties                    = 'version=1|netcdflibversion=4.4.1.1|hdf5libversion=1.8.18'
           cdm_data_type                    = 'Grid'
           Conventions                      = 'CF-1.6 ACDD-1.3, COARDS'
           creator_email                    = 'data@oceancolor.gsfc.nasa.gov'
           creator_name                     = 'NASA/GSFC/OBPG'
           creator_type                     = 'group'
           creator_url                      = 'https://oceandata.sci.gsfc.nasa.gov'
           date_created                     = '2018-01-31T04:58:26Z'
           Easternmost_Easting              = 359.9583
           geospatial_lat_max               = 89.9583
           geospatial_lat_min               = -89.9583
           geospatial_lat_units             = 'degrees_north'
           geospatial_lon_max               = 359.9583
           geospatial_lon_min               = 0.041667
           geospatial_lon_units             = 'degrees_east'
           grid_mapping_name                = 'latitude_longitude'
           history                          = 'Thu Feb  6 13:02:28 2020: ncatted -O -a sw_point_longitude,global,o,f,0.04166667 S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc
                                              Thu Feb  6 13:02:28 2020: ncatted -O -a geospatial_lon_min,global,o,f,0.0 S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc
                                              Thu Feb  6 13:02:28 2020: ncatted -O -a geospatial_lon_max,global,o,f,360.0 S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc
                                              Thu Feb  6 13:02:28 2020: ncatted -O -a easternmost_longitude,global,o,f,360.0 S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc
                                              Thu Feb  6 13:02:28 2020: ncatted -O -a westernmost_longitude,global,o,f,0.0 S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc
                                              Thu Feb  6 13:02:28 2020: ncatted -O -a valid_max,lon,o,f,360.0 S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc
                                              Thu Feb  6 13:02:28 2020: ncatted -O -a valid_min,lon,o,f,0.0 S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc
                                              Thu Feb  6 13:02:27 2020: ncap2 -O -s where(lon<0) lon=lon+360 S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc
                                              Thu Feb  6 13:02:26 2020: ncks -O --msa_usr_rdr -d lon,0.0,180.0 -d lon,-180.0,0.0 S20103352010365.L3m_MO_CHL_chlor_a_9km.nc S20103352010365.L3m_MO_CHL_chlor_a_9km-0-360.nc
                                              l3mapgen par=S20103352010365.L3m_MO_CHL_chlor_a_9km.nc.param 
                                              2022-04-21T21:53:46Z (local files)
                                              2022-04-21T21:53:46Z https://oceanwatch.pifsc.noaa.gov/erddap/griddap/sw_chla_monthly_2018_0.das'
           id                               = 'S20103352010365.L3b_MO_CHL.nc/L3/S20103352010365.L3b_MO_CHL.nc'
           identifier_product_doi           = '10.5067/ORBVIEW-2/SEAWIFS/L3M/CHL/2018'
           identifier_product_doi_authority = 'https://dx.doi.org'
           infoUrl                          = 'https://oceandata.sci.gsfc.nasa.gov'
           institution                      = 'NASA/GSFC OBPG'
           instrument                       = 'SeaWiFS'
           keywords                         = 'algorithm, biology, center, chemistry, chlor_a, chlorophyll, chlorophyllr, color, concentration, concentration_of_chlorophyll_in_sea_water, data, earth, Earth Science > Oceans > Ocean Chemistry > Chlorophyll, Earth Science > Oceans > Ocean Chemistry > Chlorophyllr, Earth Science > Oceans > Ocean Chemistry > Pigments > Chlorophyll, field, field-of-view, flight, goddard, group, gsfc, image, L3, level, level-3, mapped, nasa, obpg, ocean, ocean color, oceans, oci, palette, pigments, processing, science, sea, sea-wide, seawater, seawifs, sensor, smi, space, standard, view, water, wide'
           keywords_vocabulary              = 'GCMD Science Keywords'
           l2_flag_names                    = 'ATMFAIL,LAND,HILT,HISATZEN,STRAYLIGHT,CLDICE,COCCOLITH,LOWLW,CHLWARN,CHLFAIL,NAVWARN,MAXAERITER,ATMWARN,HISOLZEN,NAVFAIL,FILTER,HIGLINT'
           license                          = 'https://science.nasa.gov/earth-science/earth-science-data/data-information-policy/'
           map_projection                   = 'Equidistant Cylindrical'
           measure                          = 'Mean'
           naming_authority                 = 'gov.nasa.gsfc.sci.oceandata'
           NCO                              = '4.3.7'
           nco_openmp_thread_number         = 1
           Northernmost_Northing            = 89.9583
           platform                         = 'Orbview-2'
           processing_level                 = 'L3 Mapped'
           processing_version               = '2018.0'
           product_name                     = 'S20103352010365.L3m_MO_CHL_chlor_a_9km.nc'
           project                          = 'Ocean Biology Processing Group (NASA/GSFC/OBPG)'
           publisher_email                  = 'data@oceancolor.gsfc.nasa.gov'
           publisher_name                   = 'NASA/GSFC/OBPG'
           publisher_type                   = 'group'
           publisher_url                    = 'https://oceandata.sci.gsfc.nasa.gov'
           sourceUrl                        = '(local files)'
           Southernmost_Northing            = -89.9583
           spatialResolution                = '9.28 km'
           standard_name_vocabulary         = 'CF Standard Name Table v36'
           summary                          = 'Sea-Wide Field-of-View Sensor (SeaWiFS) - Monthly Ocean Color. Chlorophyll-a Concentration. 1997 - 2010. spatial resolution = 9.28km'
           temporal_range                   = '10-day'
           time_coverage_end                = '2010-12-16T12:00:00Z'
           time_coverage_start              = '1997-09-16T12:00:00Z'
           title                            = 'Chlorophyll a Concentration, SeaWIFS - Monthly, 1997-2010. v.2018.0'
           Westernmost_Easting              = 0.041667
Dimensions:
           latitude  = 2160
           longitude = 4320
           time      = 156
Variables:
    time     
           Size:       156x1
           Dimensions: time
           Datatype:   double
           Attributes:
                       _CoordinateAxisType = 'Time'
                       actual_range        = [874411200  1292500800]
                       axis                = 'T'
                       ioos_category       = 'Time'
                       long_name           = 'Centered Time'
                       standard_name       = 'time'
                       time_origin         = '01-JAN-1970 00:00:00'
                       units               = 'seconds since 1970-01-01T00:00:00Z'
    latitude 
           Size:       2160x1
           Dimensions: latitude
           Datatype:   single
           Attributes:
                       _CoordinateAxisType = 'Lat'
                       _FillValue          = NaN
                       actual_range        = [-89.9583      89.9583]
                       axis                = 'Y'
                       ioos_category       = 'Location'
                       long_name           = 'Latitude'
                       standard_name       = 'latitude'
                       units               = 'degrees_north'
                       valid_max           = 90
                       valid_min           = -90
    longitude
           Size:       4320x1
           Dimensions: longitude
           Datatype:   single
           Attributes:
                       _CoordinateAxisType = 'Lon'
                       _FillValue          = NaN
                       actual_range        = [0.04166667      359.9583]
                       axis                = 'X'
                       ioos_category       = 'Location'
                       long_name           = 'Longitude'
                       standard_name       = 'longitude'
                       units               = 'degrees_east'
                       valid_max           = 360
                       valid_min           = 0
    chlor_a  
           Size:       4320x2160x156
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue      = NaN
                       colorBarMaximum = 30
                       colorBarMinimum = 0.03
                       colorBarScale   = 'Log'
                       ioos_category   = 'Ocean Color'
                       long_name       = 'Chlorophyll Concentration, OCI Algorithm'
                       references      = 'Hu, C., Lee Z., and Franz, B.A. (2012). Chlorophyll-a algorithms for oligotrophic oceans: A novel approach based on three-band reflectance difference, J. Geophys. Res., 117, C01011, doi:10.1029/2011JC007395.'
                       standard_name   = 'concentration_of_chlorophyll_in_sea_water'
                       units           = 'mg m-3'
                       valid_max       = 100
                       valid_min       = 0.001

</code></pre>
</div>

This allows us to see the variable names that we need for the code below, which downloads the data we're interested in.  After we download the data, we're going to average the values of the area of interest for each month.

```matlab
% Download the data over area of interest
% Read the time indices, in their native units (seconds since
% 1970-01-01T00:00:00Z')
sw_time = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/sw_chla_monthly_2018_0', 'time');

% Convert this to [Y M D H M S]
sw_time_ymdhms = datevec(sw_time/86400 + datenum([1970 1 1 0 0 0])); 
lat_full = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/sw_chla_monthly_2018_0', 'latitude');
lon_full = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/sw_chla_monthly_2018_0', 'longitude');

% Find longitudes from 198 - 208 E
lon_aoi = find(lon_full >= 198 & lon_full <= 208);

% Find latitudes from 15 - 25 N
lat_aoi = find(lat_full >= 15 & lat_full <= 25);

% Start coordinates
aoi_start = [lon_aoi(1) lat_aoi(1) 1];

% Coordinates to span
aoi_span = [length(lon_aoi) length(lat_aoi) length(sw_time)];
% Download the data of interest
sw = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/sw_chla_monthly_2018_0', ...
    'chlor_a', aoi_start, aoi_span);

% Spatially average
swAVG(1:length(sw_time),1) = NaN;
for m = 1:1:length(sw_time)
    swAVG(m,1) = mean(sw(:,:,m), "all", "omitnan");
end

% Tidy up by deleting the variables we won't need again
clear lat* lon* aoi* sw m 

```

### Get monthly MODIS data, which starts in 2002
In Matlab, run the following code to view details about the data:
```matlab
% View data attributes and variables
ncdisp('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/aqua_chla_monthly_2018_0');
```

<div style="height: 200px; overflow-y: auto; border: 1px solid #ccc; padding: 10px;">
<pre><code>
Source:
           https://oceanwatch.pifsc.noaa.gov/erddap/griddap/aqua_chla_monthly_2018_0
Format:
           classic
Global Attributes:
           _lastModified                    = '2022-03-29T10:46:27.000Z'
           _NCProperties                    = 'version=2,netcdf=4.7.3,hdf5=1.12.0,'
           cdm_data_type                    = 'Grid'
           Conventions                      = 'CF-1.6 ACDD-1.3, COARDS'
           creator_email                    = 'data@oceancolor.gsfc.nasa.gov'
           creator_name                     = 'NASA/GSFC/OBPG'
           creator_type                     = 'group'
           creator_url                      = 'https://oceandata.sci.gsfc.nasa.gov'
           date_created                     = '2019-02-13T02:50:25Z'
           Easternmost_Easting              = 359.9792
           geospatial_lat_max               = 89.9792
           geospatial_lat_min               = -89.9792
           geospatial_lat_resolution        = 0.041667
           geospatial_lat_units             = 'degrees_north'
           geospatial_lon_max               = 359.9792
           geospatial_lon_min               = 0.020839
           geospatial_lon_resolution        = 0.041667
           geospatial_lon_units             = 'degrees_east'
           history                          = 'Tue Mar 29 07:10:12 2022: ncatted -O -a sw_point_longitude,global,o,f,0.02083333 A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc
                                              Tue Mar 29 07:10:12 2022: ncatted -O -a geospatial_lon_min,global,o,f,0.0 A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc
                                              Tue Mar 29 07:10:12 2022: ncatted -O -a geospatial_lon_max,global,o,f,360.0 A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc
                                              Tue Mar 29 07:10:12 2022: ncatted -O -a easternmost_longitude,global,o,f,360.0 A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc
                                              Tue Mar 29 07:10:12 2022: ncatted -O -a westernmost_longitude,global,o,f,0.0 A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc
                                              Tue Mar 29 07:10:12 2022: ncatted -O -a valid_max,lon,o,f,360.0 A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc
                                              Tue Mar 29 07:10:12 2022: ncatted -O -a valid_min,lon,o,f,0.0 A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc
                                              Tue Mar 29 07:10:09 2022: ncap2 -O -s where(lon<0) lon=lon+360 A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc
                                              Tue Mar 29 07:10:06 2022: ncks -O --msa_usr_rdr -d lon,0.0,180.0 -d lon,-180.0,0.0 A20220012022031.L3m_MO_CHL_chlor_a_4km.nc A20220012022031.L3m_MO_CHL_chlor_a_4km-0-360.nc
                                              l3mapgen par=A20220012022031.L3m_MO_CHL_chlor_a_4km.nc.param 
                                              2022-04-21T21:53:54Z (local files)
                                              2022-04-21T21:53:54Z https://oceanwatch.pifsc.noaa.gov/erddap/griddap/aqua_chla_monthly_2018_0.das'
           id                               = 'A20220012022031.L3b_MO_CHL.nc/L3/A20220012022031.L3b_MO_CHL.nc'
           identifier_product_doi           = '10.5067/AQUA/MODIS/L3M/CHL/2018'
           identifier_product_doi_authority = 'https://dx.doi.org'
           infoUrl                          = 'https://oceandata.sci.gsfc.nasa.gov'
           institution                      = 'NASA/GSFC OBPG'
           instrument                       = 'MODIS'
           keywords                         = 'algorithm, aqua, biology, center, chemistry, chlor_a, chlorophyll, chlorophyllr, color, concentration, data, earth, Earth Science > Oceans > Ocean Chemistry > Chlorophyll, Earth Science > Oceans > Ocean Chemistry > Chlorophyllr, Earth Science > Oceans > Ocean Chemistry > Pigments > Chlorophyll, flight, goddard, group, gsfc, image, imaging, L3, level, level-3, mapped, mass, mass_concentration_of_chlorophyll_in_sea_water, moderate, modis, modisa, nasa, obpg, ocean, ocean color, oceans, oci, palette, pigments, processing, resolution, science, sea, seawater, smi, space, spectroradiometer, standard, water'
           keywords_vocabulary              = 'GCMD Science Keywords'
           l2_flag_names                    = 'ATMFAIL,LAND,HILT,HISATZEN,STRAYLIGHT,CLDICE,COCCOLITH,LOWLW,CHLWARN,CHLFAIL,NAVWARN,MAXAERITER,ATMWARN,HISOLZEN,NAVFAIL,FILTER,HIGLINT'
           license                          = 'https://science.nasa.gov/earth-science/earth-science-data/data-information-policy/'
           map_projection                   = 'Equidistant Cylindrical'
           measure                          = 'Mean'
           naming_authority                 = 'gov.nasa.gsfc.sci.oceandata'
           NCO                              = 'netCDF Operators version 4.7.5 (Homepage = http://nco.sf.net, Code = https://github.com/nco/nco)'
           nco_openmp_thread_number         = 1
           Northernmost_Northing            = 89.9792
           platform                         = 'Aqua'
           processing_level                 = 'L3 Mapped'
           processing_version               = '2018.1'
           product_name                     = 'A20220012022031.L3m_MO_CHL_chlor_a_4km.nc'
           project                          = 'Ocean Biology Processing Group (NASA/GSFC/OBPG)'
           publisher_email                  = 'data@oceancolor.gsfc.nasa.gov'
           publisher_name                   = 'NASA/GSFC/OBPG'
           publisher_type                   = 'group'
           publisher_url                    = 'https://oceandata.sci.gsfc.nasa.gov'
           sourceUrl                        = '(local files)'
           Southernmost_Northing            = -89.9792
           spatialResolution                = '4.64 km'
           standard_name_vocabulary         = 'CF Standard Name Table v36'
           summary                          = 'Moderate Resolution Imaging Spectroradiometer (MODIS) Aqua - Monthly Ocean Color. Chlorophyll-a Concentration. 2002 - present. spatial resolution = 4.64km'
           temporal_range                   = 'month'
           time_coverage_end                = '2022-03-16T12:00:00Z'
           time_coverage_start              = '2002-07-16T12:00:00Z'
           title                            = 'Chlorophyll a Concentration, Aqua MODIS - Monthly, 2002-present. v.2018.0'
           Westernmost_Easting              = 0.020839
Dimensions:
           latitude  = 4320
           longitude = 8640
           time      = 237
Variables:
    time     
           Size:       237x1
           Dimensions: time
           Datatype:   double
           Attributes:
                       _CoordinateAxisType = 'Time'
                       actual_range        = [1026820800  1647432000]
                       axis                = 'T'
                       ioos_category       = 'Time'
                       long_name           = 'Centered Time'
                       standard_name       = 'time'
                       time_origin         = '01-JAN-1970 00:00:00'
                       units               = 'seconds since 1970-01-01T00:00:00Z'
    latitude 
           Size:       4320x1
           Dimensions: latitude
           Datatype:   single
           Attributes:
                       _CoordinateAxisType = 'Lat'
                       _FillValue          = NaN
                       actual_range        = [-89.9792      89.9792]
                       axis                = 'Y'
                       ioos_category       = 'Location'
                       long_name           = 'Latitude'
                       standard_name       = 'latitude'
                       units               = 'degrees_north'
                       valid_max           = 90
                       valid_min           = -90
    longitude
           Size:       8640x1
           Dimensions: longitude
           Datatype:   single
           Attributes:
                       _ChunkSizes         = 8640
                       _CoordinateAxisType = 'Lon'
                       _FillValue          = NaN
                       actual_range        = [0.0208387      359.9792]
                       axis                = 'X'
                       ioos_category       = 'Location'
                       long_name           = 'Longitude'
                       standard_name       = 'longitude'
                       units               = 'degrees_east'
                       valid_max           = 360
                       valid_min           = 0
    chlor_a  
           Size:       8640x4320x237
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue      = NaN
                       colorBarMaximum = 30
                       colorBarMinimum = 0.03
                       colorBarScale   = 'Log'
                       ioos_category   = 'Ocean Color'
                       long_name       = 'Chlorophyll Concentration, OCI Algorithm'
                       references      = 'Hu, C., Lee Z., and Franz, B.A. (2012). Chlorophyll-a algorithms for oligotrophic oceans: A novel approach based on three-band reflectance difference, J. Geophys. Res., 117, C01011, doi:10.1029/2011JC007395.'
                       standard_name   = 'mass_concentration_of_chlorophyll_in_sea_water'
                       units           = 'mg m-3'
                       valid_max       = 100
                       valid_min       = 0.001
 
</code></pre>
</div>
This allows us to see the variable names that we need for the code below, which downloads the data we're interested in.  After we download the data, we're going to average the values of the area of interest for each month.

```matlab
% Download the data over area of interest
% Read the time indices, in their native units (seconds since
% 1970-01-01T00:00:00Z')
modis_time = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/aqua_chla_monthly_2018_0', 'time'); 

% Convert this to [Y M D H M S]
modis_time_ymdhms = datevec(modis_time/86400 + datenum([1970 1 1 0 0 0])); 
lat_full = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/aqua_chla_monthly_2018_0', 'latitude');
lon_full = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/aqua_chla_monthly_2018_0', 'longitude');

% Find longitudes from 198 - 208 E
lon_aoi = find(lon_full >= 198 & lon_full <= 208);
% Find latitudes from 15 - 25 N
lat_aoi = find(lat_full >= 15 & lat_full <= 25);

% Start coordinates
aoi_start = [lon_aoi(1) lat_aoi(1) 1];

% Coordinates to span
aoi_span = [length(lon_aoi) length(lat_aoi) length(modis_time)];

% Download the data of interest
modis = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/aqua_chla_monthly_2018_0', ...
    'chlor_a', aoi_start, aoi_span);

% Spatially average
modisAVG(1:length(modis_time),1) = NaN;
for m = 1:1:length(modis_time)
    modisAVG(m,1) = mean(modis(:,:,m), "all", "omitnan");
end

% Tidy up by deleting the variables we won't need again
clear lat* lon* aoi* modis m 
```

### Get monthly VIIRS data, which starts in 2012
In Matlab, run the following code to view details about the data:


```matlab
% View data attributes and variables
ncdisp('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/noaa_snpp_chla_monthly');
```
 <div style="height: 200px; overflow-y: auto; border: 1px solid #ccc; padding: 10px;">
<pre><code>
Source:
           https://oceanwatch.pifsc.noaa.gov/erddap/griddap/noaa_snpp_chla_monthly
Format:
           classic
Global Attributes:
           _lastModified                    = '2022-02-09T19:15:34.000Z'
           cdm_data_type                    = 'Grid'
           Conventions                      = 'CF-1.6, COARDS, ACDD-1.3'
           creator_email                    = 'coastwatch.info@noaa.gov'
           creator_name                     = 'NOAA CoastWatch'
           creator_type                     = 'institution'
           creator_url                      = 'https://coastwatch.noaa.gov'
           date_created                     = '2022-03-20T01:10:06Z'
           Easternmost_Easting              = 359.9813
           geospatial_lat_max               = 89.7562
           geospatial_lat_min               = -89.7562
           geospatial_lat_resolution        = 0.0375
           geospatial_lat_units             = 'degrees_north'
           geospatial_lon_max               = 359.9813
           geospatial_lon_min               = 0.01875
           geospatial_lon_resolution        = 0.0375
           geospatial_lon_units             = 'degrees_east'
           grid_mapping_name                = 'latitude_longitude'
           history                          = 'Sun Mar 20 07:59:51 2022: ncatted -O -a sw_point_longitude,global,o,f,0.01875 V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:51 2022: ncatted -O -a geospatial_lon_min,global,o,f,0.0 V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:51 2022: ncatted -O -a geospatial_lon_max,global,o,f,360.0 V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:51 2022: ncatted -O -a easternmost_longitude,global,o,f,360.0 V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:51 2022: ncatted -O -a westernmost_longitude,global,o,f,0.0 V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:51 2022: ncatted -O -a valid_max,lon,o,f,360.0 V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:51 2022: ncatted -O -a valid_min,lon,o,f,0.0 V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:46 2022: ncap2 -O -s where(lon<0) lon=lon+360 V2022032_2022059_F28_WW00_chlora-0-360.nc V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:40 2022: ncks -O --msa_usr_rdr -d lon,0.0,180.0 -d lon,-180.0,0.0 V2022032_2022059_F28_WW00_chlora-0-360.nc V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:34 2022: ncwa -O -a altitude V2022032_2022059_F28_WW00_chlora-0-360.nc V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 07:59:29 2022: ncks -C -x -v altitude V2022032_2022059_F28_WW00_chlora.nc V2022032_2022059_F28_WW00_chlora-0-360.nc
                                              Sun Mar 20 01:10:06 2022
                                              : /data/home004/hgu/docker_v224/bin/nccomposite -M gmean -T Month -m chlor_a /data/home004/hgu/docker_v224/config/chlor_a_comp_config.input /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/monthly/WW00/V2022032_2022059_F28_WW00_chlora.nc
                                              2022-04-21T21:54:12Z (local files)
                                              2022-04-21T21:54:12Z https://oceanwatch.pifsc.noaa.gov/erddap/griddap/noaa_snpp_chla_monthly.das'
           id                               = 'L3/2km/infile_2km_G.nc'
           identifier_product_doi           = 'https://dx.doi.org'
           identifier_product_doi_authority = 'https://dx.doi.org'
           infoUrl                          = 'https://coastwatch.noaa.gov'
           input_files                      = '/data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022032_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022033_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022034_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022035_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022036_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022037_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022038_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022039_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022040_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022041_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022042_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022043_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022044_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022045_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022046_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022047_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022048_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022049_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022050_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022051_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022052_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022053_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022054_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022055_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022056_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022057_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022058_D1_WW00_chlora.nc
                                              /data/aftp/socd1/mecb/coastwatch/viirs/science/L3/global/chlora/daily/WW00/V2022059_D1_WW00_chlora.nc
                                              '
           institution                      = 'STAR'
           instrument                       = 'VIIRS'
           keywords                         = 'algorithm, chemistry, chlor_a, chlorophyll, color, concentration, data, default, earth, Earth Science > Oceans > Ocean Chemistry > Chlorophyll, Earth Science > Oceans > Ocean Optics > Ocean Color, image, imager, imager/radiometer, imaging, infrared, L3, level, level-3, mapped, mass, mass_concentration_of_chlorophyll_a_in_sea_water, national, npp, ocean, ocean color, oceans, optics, orbiting, partnership, polar, polar-orbiting, radiometer, science, sea, seawater, smi, standard, star, suite, suite/suomi-npp, suomi, time, viirs, viirs-n, viirsn, visible, water'
           keywords_vocabulary              = 'GCMD Science Keywords'
           l2_flag_names                    = 'ATMFAIL,LAND,HIGLINT,HILT,HISATZEN,CLOUD,HISOLZEN,LOWLW,CHLFAIL,NAVWARN,CLDSHDSTL,MAXAERITER,CHLWARN,ALGICE,SEAICE,NAVFAIL,FILTER'
           license                          = 'These data may be redistributed and used without restriction.'
           map_projection                   = 'geographic'
           measure                          = 'Mean'
           naming_authority                 = 'gov.noaa.coastwatch'
           NCO                              = 'netCDF Operators version 4.7.5 (Homepage = http://nco.sf.net, Code = https://github.com/nco/nco)'
           nco_openmp_thread_number         = 1
           Northernmost_Northing            = 89.7562
           platform                         = 'Suomi-NPP'
           processing_level                 = 'L3 Mapped'
           processing_version               = 'Unspecified'
           product_name                     = 'V2022032_2022059_F28_WW00_chlora.nc'
           project                          = 'Ocean Color Science Team (NOAA/NESDIS/STAR/OCST)'
           publisher_email                  = 'coastwatch.info@noaa.gov;ncei.info@noaa.gov'
           publisher_name                   = 'NOAA CoastWatch;National Centers for Environmental Information (NCEI)'
           publisher_type                   = 'group'
           publisher_url                    = 'https://coastwatch.noaa.gov;https://www.ncei.noaa.gov/'
           Satellite                        = 'Suomi-NPP'
           Sensor                           = 'VIIRS'
           sourceUrl                        = '(local files)'
           Southernmost_Northing            = -89.7562
           spatialResolution                = '4.17 km'
           standard_name_vocabulary         = 'CF Standard Name Table v29'
           summary                          = 'Visible and Infrared Imager/Radiometer Suite/Suomi-NPP (VIIRSN) produced by NOAA/STAR Ocean Color Team through NOAA Multi-Sensor Level 1 to Level 2 processing system (MSL12) using the Ocean Color improved satellite data record. This is monthly data, 4-km resolution. More info: https://coastwatch.noaa.gov/cw_html/OceanColor_Science_Quality_VIIRS_SNPP.html'
           temporal_range                   = 'Month'
           time_coverage_end                = '2022-03-01T12:00:00Z'
           time_coverage_start              = '2012-01-02T12:00:00Z'
           title                            = 'Chlorophyll a Concentration, NPP VIIRS - CoastWatch - Monthly, 2012-present'
           Westernmost_Easting              = 0.01875
Dimensions:
           latitude  = 4788
           longitude = 9600
           time      = 123
Variables:
    time     
           Size:       123x1
           Dimensions: time
           Datatype:   double
           Attributes:
                       _CoordinateAxisType = 'Time'
                       actual_range        = [1325505600  1646136000]
                       axis                = 'T'
                       calendar            = 'gregorian'
                       ioos_category       = 'Time'
                       long_name           = 'Time'
                       standard_name       = 'time'
                       time_origin         = '01-JAN-1970 00:00:00'
                       units               = 'seconds since 1970-01-01T00:00:00Z'
    latitude 
           Size:       4788x1
           Dimensions: latitude
           Datatype:   double
           Attributes:
                       _ChunkSizes         = 4788
                       _CoordinateAxisType = 'Lat'
                       actual_range        = [-89.7562      89.7562]
                       axis                = 'Y'
                       ioos_category       = 'Location'
                       long_name           = 'Latitude'
                       standard_name       = 'latitude'
                       units               = 'degrees_north'
                       valid_max           = 90
                       valid_min           = -90
    longitude
           Size:       9600x1
           Dimensions: longitude
           Datatype:   double
           Attributes:
                       _ChunkSizes         = 9600
                       _CoordinateAxisType = 'Lon'
                       actual_range        = [0.01875      359.9813]
                       axis                = 'X'
                       ioos_category       = 'Location'
                       long_name           = 'Longitude'
                       standard_name       = 'longitude'
                       units               = 'degrees_east'
                       valid_max           = 360
                       valid_min           = 0
    chlor_a  
           Size:       9600x4788x123
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue            = NaN
                       C_format              = '%.4g'
                       cell_methods          = 'time:mean altitude: mean'
                       colorBarMaximum       = 30
                       colorBarMinimum       = 0.03
                       colorBarScale         = 'Log'
                       coverage_content_type = 'physicalMeasurement'
                       grid_mapping          = 'coord_ref'
                       ioos_category         = 'Ocean Color'
                       long_name             = 'Chlorophyll Concentration, Default Algorithm'
                       references            = 'O\'Reilly J. E. et al. (1998), Ocean color chlorophyll algorithms for SeaWiFS, J. Geophys. Res., 103(C11), 2493724953'
                       standard_name         = 'mass_concentration_of_chlorophyll_a_in_sea_water'
                       units                 = 'mg m-3'
                       valid_max             = 100
                       valid_min             = 0.001
</code></pre>
</div>

<br/>
This allows us to see the variable names that we need for the code below, which downloads the data we're interested in.  After we download the data, we're going to average the values of the area of interest for each month.

```matlab
% Download the data over area of interest
% Read the time indices, in their native units (seconds since
% 1970-01-01T00:00:00Z')
viirs_time = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/noaa_snpp_chla_monthly', 'time');

% Convert this to [Y M D H M S]
viirs_time_ymdhms = datevec(viirs_time/86400 + datenum([1970 1 1 0 0 0])); 
lat_full = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/noaa_snpp_chla_monthly', 'latitude');
lon_full = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/noaa_snpp_chla_monthly', 'longitude');

% Find longitudes from 198 - 208 E
lon_aoi = find(lon_full >= 198 & lon_full <= 208);

% Find latitudes from 15 - 25 N
lat_aoi = find(lat_full >= 15 & lat_full <= 25);

% Start coordinates
aoi_start = [lon_aoi(1) lat_aoi(1) 1];

% Coordinates to span
aoi_span = [length(lon_aoi) length(lat_aoi) length(viirs_time)];
% Download the data of interest
viirs = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/noaa_snpp_chla_monthly', ...
    'chlor_a', aoi_start, aoi_span);

% Spatially average
viirsAVG(1:length(viirs_time),1) = NaN;
for m = 1:1:length(viirs_time)
    viirsAVG(m,1) = mean(viirs(:,:,m), "all", "omitnan");
end

% Tidy up by deleting the variables we won't need again
clear lat* lon* aoi* viirs m 
```

### Get monthly ESA OC-CCI data, which span Sept 1997 through Dec 2021
In Matlab, run the following code to view details about the data:

```matlab
% View data attributes and variables
ncdisp('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/esa-cci-chla-monthly-v5-0');
```

<div style="height: 200px; overflow-y: auto; border: 1px solid #ccc; padding: 10px;">
<pre><code>
Source:
           https://oceanwatch.pifsc.noaa.gov/erddap/griddap/esa-cci-chla-monthly-v5-0
Format:
           classic
Global Attributes:
           _NCProperties                    = 'version=1|netcdflibversion=4.4.1.1|hdf5libversion=1.8.20'
           cdm_data_type                    = 'Grid'
           comment                          = 'See summary attribute'
           Conventions                      = 'CF-1.7, COARDS, ACDD-1.3'
           creation_date                    = 'Sun Jan 30 23:29:22 2022'
           creator_email                    = 'help@esa-oceancolour-cci.org'
           creator_name                     = 'Plymouth Marine Laboratory'
           creator_url                      = 'https://esa-oceancolour-cci.org'
           date_created                     = '2022-01-30T23:29:22Z'
           Easternmost_Easting              = 359.9792
           geospatial_lat_max               = 89.9792
           geospatial_lat_min               = -89.9792
           geospatial_lat_resolution        = 0.041667
           geospatial_lat_units             = 'degrees_north'
           geospatial_lon_max               = 359.9792
           geospatial_lon_min               = 0.020833
           geospatial_lon_resolution        = 0.041667
           geospatial_lon_units             = 'degrees_east'
           git_commit_hash                  = 'a1fde15003a09e88bfc7cb9b7336c67bb1b55751'
           history                          = 'Thu Feb  3 08:20:51 2022: ncatted -O -a geospatial_lon_max,global,o,f,360.0 ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-202112-fv5.0-0-360.nc
                                              Thu Feb  3 08:20:51 2022: ncatted -O -a geospatial_lon_min,global,o,f,0.0 ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-202112-fv5.0-0-360.nc
                                              Thu Feb  3 08:20:51 2022: ncatted -O -a valid_max,lon,o,f,359.9792 ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-202112-fv5.0-0-360.nc
                                              Thu Feb  3 08:20:51 2022: ncatted -O -a valid_min,lon,o,f,0.02083 ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-202112-fv5.0-0-360.nc
                                              Thu Feb  3 08:20:32 2022: ncap2 -O -s where(lon<0) lon=lon+360 ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-202112-fv5.0-0-360.nc ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-202112-fv5.0-0-360.nc
                                              Thu Feb  3 08:20:13 2022: ncks -O --msa_usr_rdr -d lon,0.0,180.0 -d lon,-180.0,0.0 ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-202112-fv5.0.nc ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-202112-fv5.0-0-360.nc
                                              Source data were: ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211201-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211202-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211203-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211204-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211205-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211206-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211207-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211208-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211209-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211210-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211211-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211212-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211213-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211214-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211215-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211216-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211217-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211218-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211219-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211220-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211221-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211222-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211223-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211224-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211225-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211226-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211227-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211228-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211229-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211230-fv5.0.nc, ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1D_DAILY_4km_GEO_PML_OCx_QAA-20211231-fv5.0.nc; netcdf_compositor_cci composites  Rrs_412, Rrs_443, Rrs_490, Rrs_510, Rrs_560, Rrs_665, water_class1, water_class2, water_class3, water_class4, water_class5, water_class6, water_class7, water_class8, water_class9, water_class10, water_class11, water_class12, water_class13, water_class14, atot_412, atot_443, atot_490, atot_510, atot_560, atot_665, aph_412, aph_443, aph_490, aph_510, aph_560, aph_665, adg_412, adg_443, adg_490, adg_510, adg_560, adg_665, bbp_412, bbp_443, bbp_490, bbp_510, bbp_560, bbp_665, chlor_a, kd_490, Rrs_412_bias, Rrs_443_bias, Rrs_490_bias, Rrs_510_bias, Rrs_560_bias, Rrs_665_bias, chlor_a_log10_bias, aph_412_bias, aph_443_bias, aph_490_bias, aph_510_bias, aph_560_bias, aph_665_bias, adg_412_bias, adg_443_bias, adg_490_bias, adg_510_bias, adg_560_bias, adg_665_bias, kd_490_bias with --mean,  Rrs_412_rmsd, Rrs_443_rmsd, Rrs_490_rmsd, Rrs_510_rmsd, Rrs_560_rmsd, Rrs_665_rmsd, chlor_a_log10_rmsd, aph_412_rmsd, aph_443_rmsd, aph_490_rmsd, aph_510_rmsd, aph_560_rmsd, aph_665_rmsd, adg_412_rmsd, adg_443_rmsd, adg_490_rmsd, adg_510_rmsd, adg_560_rmsd, adg_665_rmsd, kd_490_rmsd with --root-mean-square, and  MODISA_nobs, VIIRS_nobs, OLCI_nobs, MERIS_nobs, SeaWiFS_nobs, total_nobs - with --total
                                              1643587704 Subsetted from standardised_geo/ESACCI-OC-L3S-OC_PRODUCTS-MERGED-1M_MONTHLY_4km_GEO_PML_OCx_QAA-202112-fv5.0.nc to only include variables MERIS_nobs_sum,MODISA_nobs_sum,OLCI_nobs_sum,SeaWiFS_nobs_sum,VIIRS_nobs_sum,chlor_a,chlor_a_log10_bias,chlor_a_log10_rmsd,crs,lat,lon,time,total_nobs_sum
                                              2022-04-21T21:54:29Z (local files)
                                              2022-04-21T21:54:29Z https://oceanwatch.pifsc.noaa.gov/erddap/griddap/esa-cci-chla-monthly-v5-0.das'
           id                               = 'ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-202112-fv5.0.nc'
           infoUrl                          = 'https://esa-oceancolour-cci.org/'
           institution                      = 'Plymouth Marine Laboratory'
           keywords                         = 'algorithms, aqua, area, array, array-data, bias, bin, blended, cci, cell, chemistry, chlor_a, chlor_a_log10_bias, chlor_a_log10_rmsd, chlorophyll, chlorophyll-a, class, color, colour, combination, comprehensive, concentration, contributing, count, coverage, data, depending, difference, earth, Earth Science > Oceans > Ocean Chemistry > Chlorophyll, esa, field, field-of-view, gac, generated, global, imager, imager/radiometer, imaging, infrared, laboratory, lac, large, local, log, log-transformed, log10, log10-transformed, marine, mass, mass_concentration_of_chlorophyll_a_in_sea_water, mean, memberships, meris, MERIS_nobs_sum, moderate, modis, MODISA_nobs_sum, not, number, observation, observations, oc2, ocean, ocean color, ocean colour, oceans, oci, oci2, ocx, olci, OLCI_nobs_sum, plymouth, product, radiometer, resolution, root, root-mean-square-difference, satellite, science, sea, sea-wide, seawater, seawifs, SeaWiFS_nobs_sum, sensor, spectroradiometer, square, statistics, stewardship, suite, system, time, total, total_nobs_sum, transformed, view, viirs, VIIRS_nobs_sum, visible, water, wide'
           keywords_vocabulary              = 'GCMD Science Keywords'
           license                          = 'ESA CCI Data Policy: free and open access.  When referencing, please use: Ocean Colour Climate Change Initiative dataset, Version <Version Number>, European Space Agency, available online at https://esa-oceancolour-cci.org.  We would also appreciate being notified of publications so that we can list them on the project website at https://esa-oceancolour-cci.org/?q=publications'
           naming_authority                 = 'uk.ac.pml'
           NCO                              = 'netCDF Operators version 4.7.5 (Homepage = http://nco.sf.net, Code = https://github.com/nco/nco)'
           nco_openmp_thread_number         = 1
           netcdf_file_type                 = 'NETCDF4_CLASSIC'
           Northernmost_Northing            = 89.9792
           number_of_bands_used_to_classify = '4'
           number_of_files_composited       = 31
           number_of_optical_water_types    = '14'
           platform                         = 'Orbview-2,Aqua,Envisat,Suomi-NPP, Sentinel-3a'
           processing_level                 = 'Level-3'
           product_version                  = '5.0'
           project                          = 'Climate Change Initiative - European Space Agency'
           references                       = 'https://esa-oceancolour-cci.org/'
           sensor                           = 'SeaWiFS,MODIS,MERIS,VIIRS,OLCI'
           sensors_present                  = 'MODISA OLCIa VIIRSN'
           source                           = 'NASA SeaWiFS  L1A and L2 R2018.0 LAC and GAC, MODIS-Aqua L1A and L2 R2018.0, MERIS L1B 3rd reprocessing inc OCL corrections, NASA VIIRS L1A and L2 R2018.0, OLCI L1B'
           sourceUrl                        = '(local files)'
           Southernmost_Northing            = -89.9792
           spatial_resolution               = '4km nominal at equator'
           standard_name_vocabulary         = 'CF Standard Name Table v55'
           summary                          = 'Data products generated by the Ocean Colour component of the European Space Agency Climate Change Initiative project. These files are monthly composites of merged sensor (MERIS, Moderate Resolution Imaging Spectroradiometer (MODIS) Aqua, Sea-Wide Field-of-View Sensor (SeaWiFS) Local Area Coverage (LAC) & Global Area Coverage (GAC), Visible and Infrared Imager/Radiometer Suite (VIIRS), OLCI) products.  MODIS Aqua and SeaWiFS were band-shifted and bias-corrected to MERIS bands and values using a temporally and spatially varying scheme based on the overlap years of 2003-2007.  VIIRS was band-shifted and bias-corrected in a second stage against the MODIS Rrs that had already been corrected to MERIS levels, for the overlap period 2012-2013; and at the third stage OLCI was bias corrected against already corrected MODIS, for overlap period 2016-07-01 to 2019-06-30.  VIIRS, MODIS, SeaWiFS and MERIS Rrs were derived from a combination of NASA's l2gen (for basic sensor geometry corrections, etc) and HYGEOS Polymer v4.12 (for atmospheric correction). OLCI Rrs were sourced at L1b (already geometrically corrected) and processed with polymer.  The Rrs were binned to a sinusoidal 4km level-3 grid, and later to 4km geographic projection, by Brockmann Consult's SNAP.  Derived products were generally computed with the standard algorithmsthrough SeaDAS.  QAA IOPs were derived using the standard SeaDAS algorithm but with a modified backscattering table to match that used in the bandshifting.  The final chlorophyll is a combination of OCI, OCI2, OC2 and OCx, depending on the water class memberships.  Uncertainty estimates were added using the fuzzy water classifier and uncertainty estimation algorithm of Tim Moore as documented in Jackson et al (2017). and updated accorsing to Jackson et al. (in prep).'
           time_coverage_duration           = 'P1M'
           time_coverage_end                = '2021-12-01T00:00:00Z'
           time_coverage_resolution         = 'P1M'
           time_coverage_start              = '1997-09-04T00:00:00Z'
           title                            = 'Chlorophyll a concentration, ESA OC CCI - Monthly, 1997-2021. v5.0'
           tracking_id                      = '29088af9-44c4-4b19-aa27-d1d7517c9008'
           Westernmost_Easting              = 0.020833
Dimensions:
           latitude  = 4320
           longitude = 8640
           time      = 292
Variables:
    time              
           Size:       292x1
           Dimensions: time
           Datatype:   double
           Attributes:
                       _CoordinateAxisType = 'Time'
                       actual_range        = [873331200  1638316800]
                       axis                = 'T'
                       ioos_category       = 'Time'
                       long_name           = 'Time'
                       standard_name       = 'time'
                       time_origin         = '01-JAN-1970 00:00:00'
                       units               = 'seconds since 1970-01-01T00:00:00Z'
    latitude          
           Size:       4320x1
           Dimensions: latitude
           Datatype:   double
           Attributes:
                       _CoordinateAxisType = 'Lat'
                       actual_range        = [-89.9792      89.9792]
                       axis                = 'Y'
                       ioos_category       = 'Location'
                       long_name           = 'Latitude'
                       standard_name       = 'latitude'
                       units               = 'degrees_north'
                       valid_max           = 89.9792
                       valid_min           = -89.9792
    longitude         
           Size:       8640x1
           Dimensions: longitude
           Datatype:   double
           Attributes:
                       _CoordinateAxisType = 'Lon'
                       actual_range        = [0.02083333      359.9792]
                       axis                = 'X'
                       ioos_category       = 'Location'
                       long_name           = 'Longitude'
                       standard_name       = 'longitude'
                       units               = 'degrees_east'
                       valid_max           = 359.9792
                       valid_min           = 0.02083
    chlor_a           
           Size:       8640x4320x292
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue          = NaN
                       ancillary_variables = 'chlor_a_log10_rmsd chlor_a_log10_bias'
                       colorBarMaximum     = 30
                       colorBarMinimum     = 0.03
                       colorBarScale       = 'Log'
                       grid_mapping        = 'crs'
                       ioos_category       = 'Ocean Color'
                       long_name           = 'Chlorophyll-a concentration in seawater (not log-transformed), generated by as a blended combination of OCI, OCI2, OC2 and OCx algorithms, depending on water class memberships'
                       parameter_vocab_uri = 'http://vocab.ndg.nerc.ac.uk/term/P011/current/CHLTVOLU'
                       standard_name       = 'mass_concentration_of_chlorophyll_a_in_sea_water'
                       units               = 'mg m-3'
                       units_nonstandard   = 'mg m^-3'
    MERIS_nobs_sum    
           Size:       8640x4320x292
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue                 = NaN
                       colorBarMaximum            = 100
                       colorBarMinimum            = 0
                       ioos_category              = 'Statistics'
                       long_name                  = 'Count of the number of observations from the MERIS sensor contributing to this bin cell'
                       number_of_files_composited = 31
    MODISA_nobs_sum   
           Size:       8640x4320x292
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue                 = NaN
                       colorBarMaximum            = 100
                       colorBarMinimum            = 0
                       ioos_category              = 'Statistics'
                       long_name                  = 'Count of the number of observations from the MODIS (Aqua) sensor contributing to this bin cell'
                       number_of_files_composited = 31
    OLCI_nobs_sum     
           Size:       8640x4320x292
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue                 = NaN
                       colorBarMaximum            = 100
                       colorBarMinimum            = 0
                       ioos_category              = 'Statistics'
                       long_name                  = 'Count of the number of observations from the OLCI sensor contributing to this bin cell'
                       number_of_files_composited = 31
    SeaWiFS_nobs_sum  
           Size:       8640x4320x292
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue                 = NaN
                       colorBarMaximum            = 100
                       colorBarMinimum            = 0
                       ioos_category              = 'Statistics'
                       long_name                  = 'Count of the number of observations from the SeaWiFS (GAC and LAC) sensor contributing to this bin cell'
                       number_of_files_composited = 31
    VIIRS_nobs_sum    
           Size:       8640x4320x292
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue                 = NaN
                       colorBarMaximum            = 100
                       colorBarMinimum            = 0
                       ioos_category              = 'Statistics'
                       long_name                  = 'Count of the number of observations from the VIIRS sensor contributing to this bin cell'
                       number_of_files_composited = 31
    chlor_a_log10_bias
           Size:       8640x4320x292
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue      = NaN
                       colorBarMaximum = 0.1
                       colorBarMinimum = -0.1
                       comment         = 'Uncertainty lookups derived from file: /data/datasets/CCI/v5.0-production/stage09b-uncertainty_tables/chlor_a/cci_chla_bias.dat'
                       grid_mapping    = 'crs'
                       ioos_category   = 'Statistics'
                       long_name       = 'Bias of log10-transformed chlorophyll-a concentration in seawater.'
                       ref             = 'https://esa-oceancolour-cci.org/?q=webfm_send/581'
                       rel             = 'uncertainty'
    chlor_a_log10_rmsd
           Size:       8640x4320x292
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue      = NaN
                       colorBarMaximum = 0.002
                       colorBarMinimum = 0
                       comment         = 'Uncertainty lookups derived from file: /data/datasets/CCI/v5.0-production/stage09b-uncertainty_tables/chlor_a/cci_chla_rmsd.dat'
                       grid_mapping    = 'crs'
                       ioos_category   = 'Statistics'
                       long_name       = 'Root-mean-square-difference of log10-transformed chlorophyll-a concentration in seawater.'
                       ref             = 'https://esa-oceancolour-cci.org/?q=webfm_send/581'
                       rel             = 'uncertainty'
    total_nobs_sum    
           Size:       8640x4320x292
           Dimensions: longitude,latitude,time
           Datatype:   single
           Attributes:
                       _FillValue                 = NaN
                       colorBarMaximum            = 100
                       colorBarMinimum            = 0
                       ioos_category              = 'Statistics'
                       long_name                  = 'Count of the total number of observations contributing to this bin cell'
                       number_of_files_composited = 31
</code></pre>
</div>

This allows us to see the variable names that we need for the code below, which downloads the data we're interested in.  After we download the data, we're going to average the values of the area of interest for each month.


```matlab
% Download the data over area of interest
% Read the time indices, in their native units (seconds since
% 1970-01-01T00:00:00Z')
esa_time = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/esa-cci-chla-monthly-v5-0', 'time');

% Convert this to [Y M D H M S]
esa_time_ymdhms = datevec(esa_time/86400 + datenum([1970 1 1 0 0 0])); 
lat_full = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/esa-cci-chla-monthly-v5-0', 'latitude');
lon_full = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/esa-cci-chla-monthly-v5-0', 'longitude');

% Find longitudes from 198 - 208 E
lon_aoi = find(lon_full >= 198 & lon_full <= 208);

% Find latitudes from 15 - 25 N
lat_aoi = find(lat_full >= 15 & lat_full <= 25);

% Start coordinates
aoi_start = [lon_aoi(1) lat_aoi(1) 1];

% Coordinates to span
aoi_span = [length(lon_aoi) length(lat_aoi) length(esa_time)];

% Download the data of interest
esa = ncread('https://oceanwatch.pifsc.noaa.gov/erddap/griddap/esa-cci-chla-monthly-v5-0', ...
    'chlor_a', aoi_start, aoi_span);

% Spatially average
esaAVG(1:length(esa_time),1) = NaN;
for m = 1:1:length(esa_time)
    esaAVG(m,1) = mean(esa(:,:,m), "all", "omitnan");
end

% Tidy up by deleting the variables we won't need again
clear lat* lon* aoi* esa m 
```
### Plot time series comparison
Now we can compare the spatial averages across the three sensors: SeaWiFS, MODIS, and VIIRS.  We'll do this by generating a plot the includes all three time series, which overlap to varying degrees.
```matlab
figure
plot(datenum(sw_time_ymdhms), swAVG, 'Color', [0 70 127]/255);
hold on
plot(datenum(modis_time_ymdhms), modisAVG, 'Color', [147 213 0]/255);
plot(datenum(viirs_time_ymdhms), viirsAVG, 'Color', [127 127 255]/255);
set(gca,'XTick', datenum([2000 1 1 0 0 0]):5*365:datenum([2020 1 1 0 0 0]));
set(gca,'XTickLabel', 2000:5:2020);
legend('SeaWiFS', 'MODIS', 'VIIRS', 'Location', 'southwest');
ylabel('Chlorophyll-a');
```

![Chloraophyll-a from MODIS and VIIRS](images/chlora_timeseries.png)
You can see that the values of chlorophyll-a concentration don't match across sensors.

### Make another plot with the ESA OC-CCI data to compare
The OC-CCI data are from a blended product, that merges the three sensors.


```matlab
figure
plot(datenum(sw_time_ymdhms), swAVG, 'o', 'MarkerFaceColor', [0 70 127]/255, 'MarkerEdgeColor', ...
    [0 70 127]/255); 
hold on
plot(datenum(modis_time_ymdhms), modisAVG, 'o', 'MarkerFaceColor', [147 213 0]/255, ...
    'MarkerEdgeColor', [147 213 0]/255);
plot(datenum(viirs_time_ymdhms), viirsAVG, 'o', 'MarkerFaceColor', [127 127 255]/255, ...
    'MarkerEdgeColor', [127 127 255]/255);
plot(datenum(esa_time_ymdhms), esaAVG, 'k', 'LineWidth', 2);
set(gca,'XTick', datenum([2000 1 1 0 0 0]):5*365:datenum([2020 1 1 0 0 0]));
set(gca,'XTickLabel', 2000:5:2020);
legend('SeaWiFS', 'MODIS', 'VIIRS', 'OC-CCI', 'Location', 'southwest');
ylabel('Chlorophyll-a');
```
![Chlorphyll from ESA OC-CCI](images/chlora_timeseries_occi.png)
