# Timeseries_sst.R 

# This example extracts a time-series of daily satellite SST data 
# and averages all the data into a daily averaged timeseries.
# It also generates monthly composites of the data and makes maps of months from 
# different years 
# This examples uses data from Lake Superior from 2007-present 

# xtracto_3D extracts data in a 3D bounding box where 
# xpos has the minimum and maximum, 
# ypos has the minimum and maximum latitude, and longtude
# tpos has the starting and ending time, given as "YYYY-MM-DD" describing the bounding box.

# INSTALL PACKAGES and LOAD LIBRARIES
# Function to check if pkgs are installed, install missing pkgs, and load

pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop(x, " :Package not found")
  }
}

# If modifying script add any additional packages used here 

list.of.packages <- c( "ncdf4", "rerddap","plotdap","rerddapXtracto","reshape",
                       "maps", "mapdata","ggplot2","gridExtra","lubridate",
                       "abind","colorRamps","scales")

# Install and load all libraries 

for (pk in list.of.packages) {
  pkgTest(pk)
}

#setwd("C:/Users/sssliu/Desktop/NOAA_GL_Satellite_Course_2019/R_scripts/")
#setwd("/Users/lius/CW/CW_course/2019_Great_Lakes_Satellite_course/R_scripts/")

# Get all data from Lake Superior

dataInfo <- rerddap::info('GLSEA_ACSPO_GCS',  url="https://coastwatch.glerl.noaa.gov/erddap/")

# This extracts the parameter name from the metadata in dataInfo
parameter <- dataInfo$variable$variable_name

# This extracts the start and end times of the dataset from the metadata in dataInfo
# global <- dataInfo$alldata$NC_GLOBAL

# Set up the longitude-latitude boundaries of the dataset 

#xcoord <- as.numeric(global[ global$attribute_name %in% c('geospatial_lon_min','geospatial_lon_max'), "value", ])
#ycoord <- as.numeric(global[ global$attribute_name %in% c('geospatial_lat_min','geospatial_lat_max'), "value", ])
xcoord <- c(-93,-84)
ycoord <- c(46,49.5)

# There is a 2 Gbyte limit on download requests, and so its not possible to download the 
# entire timeseries in one request.  So we will set up a do loop and extract the data 
# one year at a time, and generate monthly composites

ys <- 2007
ye <- 2022

for (iy in (ys:ye)) {
  start_time <- Sys.time()

  print(paste("Processing",iy))
  tcoord <- c(paste0(iy,"-01-01",sep=""),paste0(iy,"-12-31",sep="")) 
#  tcoord <- c(paste0(iy,"-01-01T12:00:00Z",sep=""),paste0(iy,"-12-31T12:00:00Z",sep="")) 
  
  if (iy == ye) {tcoord <-c(paste0(iy,"-01-01",sep=""),"last")}
# Extract the data 
 
  rerddap::cache_delete_all(force = TRUE)
  sstGL<-rxtracto_3D(dataInfo,parameter=parameter,
                        tcoord=tcoord,
                        xcoord=xcoord,ycoord=ycoord)

# Generate monthly composites 
# There is probably a more efficient way to do it rather than using a loop!
# But this works and should be relatively understandable code...
# Monthly composites will be stored in mmap 
# the (centered) times will be in the mtime variable 

  for (im in min(month(sstGL$time)):max(month(sstGL$time))) {
  
  indices <- which(month(sstGL$time)==im)
  temp <- sstGL$sst[,,indices]
  tmap <- apply(temp,c(1,2),function(x) mean(x,na.rm=TRUE))
  
  if (im == min(month(sstGL$time))) {
    m1map <- tmap 
    m1time <- as.Date(paste0(iy,'-',im,'-',15)) }
  else {
    m1map <- abind(m1map,tmap,along=3) 
    m1time <- c(m1time,as.Date(paste0(iy,'-',im,'-',15))) }
  }
  if (iy == ys) {
    mmap <- m1map 
    mtime <- m1time }
  else {
    mmap <- abind(mmap,m1map,along=3) 
    mtime <- c(mtime,m1time) }

  end_time <- Sys.time()
  
  print(end_time - start_time)
}

msstGL <- list(sst=mmap, longitude=sstGL$longitude, latitude=sstGL$latitude, time=mtime)

#  Now print out maps of each month 
#  We will use ggplot, which requires flattening out the arrays into long 
#  vectors.

melt_map <- function(lon,lat,var) {
  dimnames(var) <-list(Longitude=lon, Latitude=lat)
  ret <- melt(var,value.name="sst")
}

# Get coastline 
 coast <- map_data("lakes", ylim = range(ycoord), xlim = range(xcoord))

# Loop for making maps

for(i in 1:length(mtime)) {

  mtext <- paste(months(mtime[i],abbr=TRUE),year(mtime[i]),sep="")
  file_name = paste("LS_SST_",mtext,".png", sep="")
  sstmap <- melt_map(sstGL$longitude, sstGL$latitude, mmap[,,i])

  # The melt_map function should return a dataframe with the variable name "sst" 
  # but for some reason wasn't, hence this next line 
    names(sstmap)[which(names(sstmap)  == "value")] <- "sst"
    
  p = ggplot(data = sstmap, aes(x = Longitude, y = Latitude, fill = sst)) +
    geom_raster(interpolate = FALSE, na.rm=T) +
    theme_bw(base_size = 30) + ylab("Latitude") + xlab("Longitude") +
    coord_fixed(1.3, xlim = xcoord, ylim = ycoord) +
    scale_fill_gradientn(colours = c(matlab.like(12),"black"),limits=c(0,20), na.value = NA, oob=squish) +
    geom_polygon(data=coast,aes(x=long,y=lat,group=group),colour="black",fill=NA) +
    ggtitle(mtext)
  
  png(file_name, width=1200,height=1200)
  print(p)
  dev.off()
  
}


# Now make a timeseries of the monthly dataset
#  
month_ts <- apply(mmap, c(3),function(x) mean(x,na.rm=TRUE))

# Plot the monthly timeseries, overlain with the daily points 
# To print out a file uncomment the png command 

#png(file="SST_timeseries.png", width=10,height=7.5,units="in",res=500)

plot(mtime,month_ts,type='l', lwd=1, main="Lake Superior", 
     ylab="Temperature", xlab="")


#dev.off()

