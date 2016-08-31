### Problem 1 ###

if (!file.exists("IdahoHousing.csv")) {
    download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                  destfile="./IdahoHousing.csv", method="curl")
}

data <- read.csv("IdahoHousing.csv")

# Create a logical vector and find the indices of true values
agricultureLogical <- (data$ACR==3 & data$AGS==6)
which(agricultureLogical)


### Problem 2 ###

# Uncomment the below lines to install if not installed:
# install.packages("jpeg")

library(jpeg)

# Download the .jpg file from the web
if (!file.exists("jeff.jpg")) {
    jpegUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
    download.file(jpegUrl, destfile="jeff.jpg", method="curl")    
}

# Read in the .jpg image
jeffJPG <- readJPEG("jeff.jpg",native=TRUE)

# Check the 30th and 80th percentiles of the resulting raster data:
quantile(jeffJPG, probs = c(.30,.80))



### Problem 3 ###

# Download the GDP data
if (!file.exists("gdp.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(fileUrl, destfile="gdp.csv", method="curl")
    dateDownloadedGDP <- date
}

# Load in the GDP data:
gdp <- read.csv("gdp.csv")

# Download the education data
if (!file.exists("education.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "
    download.file(fileUrl, destfile="education.csv", method="curl")
    dateDownloadedEducation <- date
}

education <- read.csv("education.csv")

# Merge the GDP and education data sets on the country code
merged <- merge(gdp[5:194,],education,by.x="X",by.y="CountryCode")
dim(merged)

# Sort by GDP rank in decreasing order
merged$GDPOrder <- as.numeric(as.character(merged$Gross.domestic.product.2012))
sorted <- merged[order(merged$GDPOrder,decreasing=TRUE),]

sorted[13,]



### Problem 4 ###

mean(merged[merged$Income.Group=="High income: OECD",]$GDPOrder); 
mean(merged[merged$Income.Group=="High income: nonOECD",]$GDPOrder); 



### Problem 5 ###

merged$GDPGroup <- cut(merged$GDPOrder, 5)
table(merged$GDPGroup, merged$Income.Group)
