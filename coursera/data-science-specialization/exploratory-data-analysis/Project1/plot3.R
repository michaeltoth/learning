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
png(filename = "plot3.png", width = 480, height = 480)

# Set parameters and create plot2, without data series
par(mfrow = c(1,1))
plot(x = housePower$Datetime,
     y = housePower$Sub_metering_1,
     type = "n",
     col = "black",
     ylab = "Energy sub metering",
     xlab = "")

# Add 3 data series to the plot for each sub metering
lines(x = housePower$Datetime, y = housePower$Sub_metering_1, col = "black")
lines(x = housePower$Datetime, y = housePower$Sub_metering_2, col = "red")
lines(x = housePower$Datetime, y = housePower$Sub_metering_3, col = "blue")

# Adding a legend to the top-right
legend("topright", 
       lty = 1,
       legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), 
       col = c("black","red","blue"))

# Turn off png graphics device
dev.off()