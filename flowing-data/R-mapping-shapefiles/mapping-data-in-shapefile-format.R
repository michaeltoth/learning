library(maptools)
library(rgdal)

setwd('~/dev/learning/flowing-data/R-mapping-shapefiles/')

# Plot for U.S. Primary Roads
priroads <- readShapeLines("data/us_primaryroads/tl_2015_us_primaryroads.shp")

# Specify the current projection (none, base longlat) for the shapefile
# This tells R what we are converting FROM, which is needed
proj4string(priroads) <- CRS("+proj=longlat")

# We'll use the Albers projection, the standard for U.S. maps these days
albers <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lon_0=97.2w"
priroads_albers <- spTransform(priroads, CRS(albers))


png("primary-roads.png", width = 960, height = 600)
par(mar = c(0, 0, 0, 0), bg = '#f0f0f0')
plot(0, 0, type = "n", axes = F, xlim = c(-1000000, 1000000), 
     ylim = c(2356848, 5500627), asp = 1)
lines(priroads_albers, lwd = 0.07)
dev.off()

# Plot for New York County (Manhattan)
countyroads <- readShapeLines("data/manhattan_roads/tl_2014_36061_roads.shp")
usroads <- subset(countyroads, RTTYP == "U")
otherroads <- subset(countyroads, RTTYP != "U")

png("newyork-county-roads-color.png", width=960, height=700, bg="#f0f0f0")
par(mar=c(0,0,0,0))
plot(0, 0, type="n", axes=FALSE, xlim=countyroads@bbox["x",], ylim=countyroads@bbox["y",], xlab=NA, ylab=NA)
lines(usroads, col="red", lwd=2)
lines(otherroads, col="black", lwd=0.3)
dev.off()