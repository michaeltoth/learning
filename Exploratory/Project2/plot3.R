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

# Sum total emissions by year by type
baltimoreEmissionsType <- aggregate(Emissions ~ year+type, 
                                    data = NEI_Baltimore, sum)

# Create plot of emissions by type using facet grid in ggplot
ggplot(data = baltimoreEmissionsType, aes(as.factor(year), Emissions)) + 
    geom_bar(stat="identity") + facet_grid(. ~ type) + xlab("Year") + 
    ylab(expression("PM"[2.5]*" Emissions")) + 
    ggtitle("Baltimore - Emissions by Source Type") + 
    theme(plot.title = element_text(lineheight=.8, face="bold"))
    
# Save to .png file
ggsave(filename = "plot3.png", width = 8, height = 6, dpi = 100)
