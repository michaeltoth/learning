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

# After some exploration, I found that both grep("Coal", SCC$Short.Name) and
# union(grep("Coal", SCC$SCC.Level.Three), grep("Coal", SCC$SCC.Level.Four))
# return the same list of values, all associated with coal combustion.  This
# deliberately excludes charcoal combustion sources.

# Extract only those observations from coal combustion sources
SCC_Coal <- SCC[grep("Coal", SCC$Short.Name),]
NEI_Coal <- NEI[NEI$SCC %in% SCC_Coal$SCC,]

# Sum total emissions by year from coal sources
coalEmissions <- aggregate(Emissions ~ year, data = NEI_Coal, sum)

# Set graphics device to png
png(filename = "plot4.png")

# Create barplot, dividing by 1000 to avoid scientific notation in plot
barplot(coalEmissions$Emissions/1000, names.arg = coalEmissions$year,
        main = "U.S. - Emissions from Coal Sources", xlab = "Year",
        ylab = expression("PM"[2.5]*" Emissions in Thousands"), col = "skyblue",
        ylim=c(0,600))

# Turn off png graphics device
dev.off()