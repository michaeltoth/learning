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

# Sum total emissions by year from all sources
totalEmissions <- aggregate(Emissions ~ year, data = NEI, sum)

# Set plot parameters
par(las = 1, family = "Helvetica", cex.axis = 0.8)

# Set graphics device to png
png(filename = "plot1.png")

# Plot, converting values to millions to avoid scientific notation in plot image
barplot(totalEmissions$Emissions/1000000, names.arg = totalEmissions$year,
        main = "U.S. - Total Emissions from All Sources", xlab = "Year",
        ylab = expression("PM"[2.5]*" Emissions in Millions"), col = "skyblue",
        ylim = c(0,8))

# Turn off png graphics device
dev.off()