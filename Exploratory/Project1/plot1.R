# Exercise assumes you have downloaded and extracted the zip file
# household_power_consumption_dated.txt is a pre-subsetted file by date
# household_power_consumption_dated.txt must be in the working directory

# Load in file that has already been subsetted to Feb 1-2 2007
if ( !exists("housePower")) {
    housePower <- read.table("household_power_consumption_dated.txt", 
        sep = ";", 
        header = TRUE)
    
    # Add a datetime column that combines the date and time columns
    housePower$Datetime <- as.POSIXct(paste(housePower$Date, housePower$Time), 
        format = "%d/%m/%Y %H:%M:%S")
}

# Set graphics device to png
png(filename = "plot1.png", width = 480, height = 480)

# Set parameters and create plot1
par(mfrow = c(1,1))
hist(housePower$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     breaks = 15)

# Turn off png graphics device
dev.off()