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
totalEmissions <- aggregate(NEI$Emissions, by = list(NEI$year), sum)
colnames(totalEmissions) <- c("Year", "Emissions")

plot(x = totalEmissions$Year, y = totalEmissions$Emissions, xlim = c(1998,2008), 
     ylim = c(3500000,7500000), main = "Total Yearly Emissions", 
     ylab = expression("PM"[2.5]*" Emissions"), xlab = "Year")
