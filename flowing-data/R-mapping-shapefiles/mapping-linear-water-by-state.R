# All data from ftp://ftp2.census.gov/geo/tiger/TIGER2016/LINEARWATER/
# Download via FTP into the data/linearwater folder in your working directory

library(maps)
library(maptools)
library(rgdal)
library(stringr)
library(dplyr)
library(readr)

setwd('~/dev/learning/flowing-data/R-mapping-shapefiles/')
filedir <- './data/linearwater/'

state_fips <- read_csv('state_fips.csv')

f <- function(entry) {
    current_state <- entry$State    
    print(paste0('Plotting for ', current_state))
    
    png(paste0(current_state, '-rivers-albers.png'), width = 10000, height = 5700, bg = "#f0f0f0")
    par(mar = c(0, 0, 0, 0))
    plot(0, 0, type = "n", axes = F, xlab = NA, ylab = NA, asp = 1)
    
    filenames <- list.files(filedir, pattern = paste0("\\_", entry$FIPS, ".*\\.shp$")) %>% str_replace('.shp', '')
    for (i in 1:length(filenames)) {
        current <- readOGR(filedir, filenames[i], verbose = F)
        lines(current, lwd = 0.07, col = '#023AED')
    }
    dev.off()
}

by(state_fips, 1:nrow(state_fips), f)


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
