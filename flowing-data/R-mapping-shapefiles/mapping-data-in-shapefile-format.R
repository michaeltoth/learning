library(maptools)
library(rgdal)

setwd('~/dev/learning/flowing-data/R-mapping-shapefiles/')

# Plot for U.S. Primary Roads
priroads <- readShapeLines("data/us_primaryroads//tl_2015_us_primaryroads.shp")

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
countyroads <- readShapeLines("data/manhattan_roads//tl_2014_36061_roads.shp")
usroads <- subset(countyroads, RTTYP == "U")
otherroads <- subset(countyroads, RTTYP != "U")

png("newyork-county-roads-color.png", width=960, height=700, bg="#f0f0f0")
par(mar=c(0,0,0,0))
plot(0, 0, type="n", axes=FALSE, xlim=countyroads@bbox["x",], ylim=countyroads@bbox["y",], xlab=NA, ylab=NA)
lines(usroads, col="red", lwd=2)
lines(otherroads, col="black", lwd=0.3)
dev.off()

# Plot for All of NYC
manhattan <- readShapeLines("data/manhattan_roads/tl_2014_36061_roads.shp")
queens <- readShapeLines("data/queens_roads/tl_2014_36081_roads.shp")
bronx <- readShapeLines("data/bronx_roads/tl_2014_36005_roads.shp")
brooklyn <- readShapeLines("data/brooklyn_roads/tl_2014_36047_roads.shp")
statenisland <- readShapeLines("data/statenisland_roads/tl_2014_36085_roads.shp")

# Find Minimum & Maximum Longitude & Latitude for Plot
x1 <- min(manhattan@bbox["x", 1], queens@bbox["x", 1], bronx@bbox["x", 1], brooklyn@bbox["x", 1], statenisland@bbox["x", 1])
x2 <- max(manhattan@bbox["x", 2], queens@bbox["x", 2], bronx@bbox["x", 2], brooklyn@bbox["x", 2], statenisland@bbox["x", 2])
y1 <- min(manhattan@bbox["y", 1], queens@bbox["y", 1], bronx@bbox["y", 1], brooklyn@bbox["y", 1], statenisland@bbox["y", 1])
y2 <- max(manhattan@bbox["y", 2], queens@bbox["y", 2], bronx@bbox["y", 2], brooklyn@bbox["y", 2], statenisland@bbox["y", 2])

png("newyork-roads.png", width=960, height=1200, bg="#f0f0f0")
par(mar=c(0,0,0,0))
plot(0, 0, type="n", axes=FALSE, xlim=c(x1, x2), ylim=c(y1, y2), xlab=NA, ylab=NA)
lines(manhattan, col="black", lwd=0.3)
lines(queens, col="black", lwd=0.3)
lines(bronx, col="black", lwd=0.3)
lines(brooklyn, col="black", lwd=0.3)
lines(statenisland, col="black", lwd=0.3)
dev.off()
