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

# After some exploration, I found that both grep("Vehicle", SCC$Short.Name)
# returns many non-vehicle sources that have "vehicle" in the name, so those are
# exluded.  Similar results for the SCC.Level.Four variable.  Using SCC.Level.Two
# and SCC.Level.Three seems to get at the sources we want.

# Extract only those observations from motor vehicle sources
SCC_Vehicles <- SCC[union(grep("Vehicle", SCC$SCC.Level.Two),
                          grep("Vehicle", SCC$SCC.Level.Three)),]
NEI_Baltimore_Vehicles <- NEI_Baltimore[NEI_Baltimore$SCC %in% SCC_Vehicles$SCC,]

# Sum Baltimore emissions by year from motor vehicle sources
baltimoreVehicleEmissions <- aggregate(Emissions ~ year, 
                                       data = NEI_Baltimore_Vehicles, sum)

barplot(baltimoreVehicleEmissions$Emissions, col = "skyblue", xlab = "Year",
        names.arg = baltimoreVehicleEmissions$year,
        main = "Baltimore - Emissions from Motor Vehicle Sources", 
        ylab = expression("PM"[2.5]*" Emissions"))
