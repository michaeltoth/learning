## Download and load csv ##

# Download file if we haven't already
if (!file.exists("IdahoHousing.csv")) {
    download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile="./IdahoHousing.csv", method="curl")
}

data <- read.csv("IdahoHousing.csv")

# Properties over $1,000,000:
value_1M <- sum(data$VAL == 24, na.rm=TRUE)


## Download and load xlsx ##

library(xlsx)

# Download file if we haven't already
if (!file.exists("NaturalGas.xlsx")) {
    download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
                  destfile="./NaturalGas.xlsx", method="curl")
}

colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./NaturalGas.xlsx", sheetIndex=1, colIndex=colIndex, 
                 rowIndex=rowIndex)

answer <- sum(dat$Zip*dat$Ext,na.rm=T)


## Download and load xml ##

library(XML)

# Download file and load.  xmlTreeParse does not support https!
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)

rootNode <- xmlRoot(doc)

# Extract zip codes from XML
zipCodes <- xpathSApply(rootNode,"//zipcode",xmlValue)
num_21231 <- sum(zipCodes == "21231")


# Download and load csv again
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
if (!file.exists("IdahoHousing2.csv")) {
    download.file(fileUrl, destfile="IdahoHousing2.csv", method="curl")
}

library(data.table)

data <- read.csv("IdahoHousing2.csv")
DT <- data.table(data)

# Iteratively test the timing for each valid expression
ptm <- proc.time()
for (i in 1:1000) {
    mean(DT[DT$SEX==1,]$pwgtp15); 
}

proc.time() - ptm
