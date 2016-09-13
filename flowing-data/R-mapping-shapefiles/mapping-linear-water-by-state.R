# All data from ftp://ftp2.census.gov/geo/tiger/TIGER2016/LINEARWATER/
# Download via FTP into the data/linearwater folder in your working directory

library(maps)
library(maptools)
library(rgdal)
library(stringr)
library(dplyr)
library(readr)
library(ggplot2)

setwd('~/dev/learning/flowing-data/R-mapping-shapefiles/')
filedir <- './data/linearwater/'

state_fips <- read_csv('state_fips.csv')

state_records <- data.frame(state = character(), minx = numeric(), maxx = numeric(), miny = numeric(), maxy = numeric())

get_state_coordinates <- function(entry) {
    current_state <- entry$State    
    print(paste0('Getting coordinates for ', current_state))
    
    filenames <- list.files(filedir, pattern = paste0("\\_", entry$FIPS, ".*\\.shp$")) %>% str_replace('.shp', '')
    
    records <- data.frame(minx = numeric(), maxx = numeric(), miny = numeric(), maxy = numeric())
    #for (i in 1:length(filenames)) {
    for (i in 1:5) {
        print(paste0('Reading ', i, ' of ', length(filenames), ': ', filenames[i]))
        current <- readOGR(filedir, filenames[i], verbose = F)
        records <- rbind(records, data.frame(minx = current@bbox[1], maxx = current@bbox[3], miny = current@bbox[2], maxy = current@bbox[4]))
    }
    
    state_records <- rbind(state_records, 
                           data.frame(state = current_state, 
                                minx = min(records$minx),
                                maxx = max(records$maxx),
                                miny = min(records$miny),
                                maxy = max(records$maxy)))
    
    state_records
}

by(head(state_fips, n = 2), 1:nrow(head(state_fips, n = 2)), get_state_coordinates)



plot_states <- function(entry) {
    current_state <- entry$State    
    print(paste0('Plotting for ', current_state))
    
    # What's causing those weird dense anomalies in the graphs?
    # Figure out how to plot ggplot
    # Is ggplot most efficient?
    png(paste0(current_state, '-rivers-albers.png'), width = 5700, height = 10000, bg = "#f0f0f0")
    #p <- ggplot() + xlim(c(-88.1225, -85.06665)) + ylim(c(30.22944, 34.26048)) + xlab('') + ylab('')
    par(mar = c(0, 0, 0, 0))
    plot(0, 0, type = "n", axes = F, xlim = c(-89.1225, -84.06665),
         ylim = c(29.22944, 35.26048), xlab = NA, ylab = NA, asp = 1)
    filenames <- list.files(filedir, pattern = paste0("\\_", entry$FIPS, ".*\\.shp$")) %>% str_replace('.shp', '')

    for (i in 1:length(filenames)) {
        print(paste0('Plotting ', i, ' of ', length(filenames), ': ', filenames[i]))
        current <- readOGR(filedir, filenames[i], verbose = F)
        current <- subset(current, MTFCC == "H3010")
        lines(current, lwd = 1, col = '#023AED')
        #current_fortify <- fortify(current)
        #p <- p + geom_path(data = current_fortify, aes(x = long, y = lat, group = group), size = 0.25)
    }

    #print(p)
    
    dev.off()
}

by(head(state_fips, n = 1), 1:nrow(head(state_fips, n = 1)), plot_states)
