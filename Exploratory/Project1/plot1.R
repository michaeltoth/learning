# Exercise assumes you have downloaded and extracted the zip file
# and that household_power_consumption.txt is in the working directory

if ( !exists("housePower")) {
    housePower <- read.table("household_power_consumption.txt", sep=";", 
            header = TRUE)
}

# Subset the dataset to only include 2/1/2007 and 2/2/2007 data
housePower <- housePower[housePower$Date %in% c("1/2/2007","2/2/2007"),]

# Convert date and time fields.  Currently incorrect
housePower$Date <- as.Date(as.character(housePower$Date), format="%d/%m/%Y")
housePower$Time <- strptime(housePower$Time, format="%H:%M:%S")
