# Exercise assumes you have downloaded and extracted the zip file
# household_power_consumption_dated.txt is a pre-subsetted file by date
# household_power_consumption_dated.txt must be in the working directory

# Load in file that has already been subsetted to Feb 1-2 2007
if ( !exists("housePower")) {
    housePower <- read.table(file = "household_power_consumption_dated.txt", 
        sep = ";", 
        header = TRUE)
    
    # Add a datetime column that combines the date and time columns
    housePower$Datetime <- as.POSIXct(paste(housePower$Date, housePower$Time), 
        format = "%d/%m/%Y %H:%M:%S")
}

# Set graphics device to png
png(filename = "plot2.png", width = 480, height = 480)

# Set parameters and create plot2
par(mfrow = c(1,1))
plot(x = housePower$Datetime, 
     y = housePower$Global_active_power, 
     type = "l",
     col = "black",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# Turn off png graphics device
dev.off()