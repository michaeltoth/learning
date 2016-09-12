library(maptools)
library(rgdal)

setwd('~/dev/learning/flowing-data/R-mapping-shapefiles/')
counties <- readShapeSpatial("data/counties/County_2010Census_DP1.shp")

# Specify the current projection (none, base longlat) for the shapefile
# This tells R what we are converting FROM, which is needed
proj4string(counties) <- CRS("+proj=longlat")

# We'll use the Albers projection, the standard for U.S. maps these days
albers <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lon_0=97.2w"
counties_albers <- spTransform(counties, CRS(albers))


# Look at a specific metric
currMetric <- "DP0200001"  # Rental vacancy rate (percent)
summary(counties_albers@data[, currMetric])
hist(counties_albers@data[, currMetric], breaks = 0:54)

# Color for quartiles
findColor4 <- function(x) {
    if (x < 7.8) {
        col <- "#fee5d9"
    } else if (x < 9.5) {
        col <- "#fcae91"
    } else if (x < 11.6) {
        col <- "#fb6a4a"
    } else {
        col <- "#cb181d"
    }
    
    return(col)
}

countyColors4 <- sapply(counties_albers@data[,currMetric], findColor4)

plot(counties_albers, col=countyColors4, xlim=c(-2000000,3000000), ylim=c(2314503, 5520938), lwd=0.01)



# ggplot experimentations
# create a blank ggplot theme
theme_opts <- list(theme(panel.grid.minor = element_blank(),
                         panel.grid.major = element_blank(),
                         panel.background = element_blank(),
                         plot.background = element_rect(fill="#e6e8ed"),
                         panel.border = element_blank(),
                         axis.line = element_blank(),
                         axis.text.x = element_blank(),
                         axis.text.y = element_blank(),
                         axis.ticks = element_blank(),
                         axis.title.x = element_blank(),
                         axis.title.y = element_blank(),
                         plot.title = element_text(size=22)))

ggplot(test, aes(long, lat, group=group, fill = hole)) +
    geom_polygon() +
    theme_opts
    coord_equal()