# All data from ftp://ftp2.census.gov/geo/tiger/TIGER2016/LINEARWATER/
# Download via FTP into the data/linearwater folder in your working directory

library(maptools)
library(rgdal)
library(stringr)

setwd('~/dev/learning/flowing-data/R-mapping-shapefiles/')
filedir <- './data/linearwater/'

# Define Albers projection
albers <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lon_0=97.2w"

# Find all files ending in .shp
filenames <- list.files(filedir, pattern = "\\.shp$") %>% str_replace('.shp', '')

# Create Plot
png('united-states-rivers-albers.png', width = 10000, height = 5700, bg = "#f0f0f0")
par(mar = c(0, 0, 0, 0))
plot(0, 0, type = "n", axes = F, xlim = c(-1000000, 1000000), 
     ylim = c(2356848, 5500627), xlab = NA, ylab = NA, asp = 1)
for (i in 1:length(filenames)) {
    print(paste0('Plotting ', i, ' of ', length(filenames), ': ', filenames[i]))
    current <- readOGR(filedir, filenames[i], verbose = F)
    current_albers <- spTransform(current, CRS(albers))
    lines(current_albers, lwd = 0.07, col = '#023AED')
}
dev.off()
