# Create data directory
if (!file.exists("data/")) { dir.create("data") }

# Download and extract data.  This may take a minute or two.
file1 = "data/Source_Classification_Code.rds"
file2 = "data/summarySCC_PM25.rds"
if (!file.exists(file1) | !file.exists(file2)) {
    # Download file from course site
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileUrl, destfile = "data/FNEI_data.zip", method="curl")
    dateDownloaded <- date()
    
    # Extract file contents
    unzip("data/FNEI_data.zip", exdir = "data")
}

# Read files into R using readRDS.  This may take a minute or two
if (!exists("NEI")) { NEI <- readRDS("data/summarySCC_PM25.rds") }
if (!exists("SCC")) { SCC <- readRDS("data/Source_Classification_Code.rds") }

# Subset Baltimore NEI Data
NEI_Baltimore <- NEI[NEI$fips == "24510",]
NEI_LA <- NEI[NEI$fips == "06037",]

# After some exploration, I found that both grep("Vehicle", SCC$Short.Name)
# returns many non-vehicle sources that have "vehicle" in the name, so those are
# exluded.  Similar results for the SCC.Level.Four variable.  Using SCC.Level.Two
# and SCC.Level.Three seems to get at the sources we want.

# Extract only those observations from motor vehicle sources
SCC_Vehicles <- SCC[union(grep("Vehicle", SCC$SCC.Level.Two),
                          grep("Vehicle", SCC$SCC.Level.Three)),]
NEI_Baltimore_Vehicles <- NEI_Baltimore[NEI_Baltimore$SCC %in% SCC_Vehicles$SCC,]
NEI_LA_Vehicles <- NEI_LA[NEI_LA$SCC %in% SCC_Vehicles$SCC,]

# Sum Baltimore  & LA emissions by year from motor vehicle sources
baltimoreVehicleEmissions <- aggregate(Emissions ~ year, data = NEI_Baltimore_Vehicles, sum)
LAVehicleEmissions <- aggregate(Emissions ~ year, data = NEI_LA_Vehicles, sum)

# Combine both cities into a single data set
cityEmissions <- rbind(baltimoreVehicleEmissions, LAVehicleEmissions)
cityEmissions$city <- rep(c("Baltimore","LA"), each=4)

# Create plot of motor vehicle emissions by city using facet grid in ggplot
ggplot(data = cityEmissions, aes(as.factor(year), Emissions)) + 
    geom_bar(stat="identity") + facet_grid(. ~ city) + xlab("Year") + 
    ylab(expression("PM"[2.5]*" Emissions")) + 
    ggtitle("Motor Vehicle Emissions by City") + 
    theme(plot.title = element_text(lineheight=.8, face="bold"))

# Save to .png file
ggsave(filename = "plot6.png", width = 6, height = 8)