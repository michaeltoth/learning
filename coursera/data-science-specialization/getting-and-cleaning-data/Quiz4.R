### Question 1 ###

# Download and read in housing data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="housing.csv", method="curl")
dateDownloaded <- date
housing <- read.csv("housing.csv", header=TRUE)

# Split variable names on characters "wgtp"
splitNames = strsplit(names(housing),"wgtp")
splitNames[[123]]


### Question 2 ###

# Download and read in GDP data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile="gdp.csv", method="curl")
dateDownloadedGDP <- date
gdp <- read.csv("gdp.csv")
gdp$X.3[5:194]

# Extracting GDP, stripping commas, converting to numeric:
mean(as.numeric(gsub(",","",gdp$X.3[5:194])))



### Question 3 ###

# Create country names variable and find countries starting with "United"
countryNames <- gdp$X.2[5:194]
grep("^United",countryNames)



### Question 4 ###

# Download and load required GDP and education data sets
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile="gdp.csv", method="curl")
dateDownloadedGDP <- date
gdp <- read.csv("gdp.csv")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "
download.file(fileUrl, destfile="education.csv", method="curl")
dateDownloadedEducation <- date
education <- read.csv("education.csv")

merged <- merge(gdp,education,by.x="X",by.y="CountryCode")
notes <- merged$Special.Notes
fiscal <- grep("[Ff]iscal",notes,value=TRUE)
june <- grep("June",fiscal,value=TRUE)
length(june)


### Question 5 ###

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# Finding all dates in 2012
all2012 <- as.Date(grep(2012,sampleTimes,value=TRUE))
length(all2012)

# Finding Mondays in 2012
days <- grep("Monday",weekdays(all2012),value=TRUE)
length(days)
