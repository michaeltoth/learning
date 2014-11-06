# Exercise assumes you have downloaded and extracted the zip file
# and that household_power_consumption.txt is in the working directory

if ( !exists("housePower")) {
    housePower <- read.table(file = "household_power_consumption_dated.txt", 
        sep = ";", 
        header = TRUE)

    housePower$Datetime <- as.POSIXct(paste(housePower$Date, housePower$Time), 
        format = "%d/%m/%Y %H:%M:%S")
}

par(mfrow = c(2,2))
# Plot 1 (top left)
plot(x = housePower$Datetime, 
     y = housePower$Global_active_power, 
     type = "l",
     col = "black",
     ylab = "Global Active Power",
     xlab = "")


# Plot 2 (upper right)
plot(x = housePower$Datetime, 
     y = housePower$Voltage, 
     type = "l",
     col = "black",
     ylab = "Voltage",
     xlab = "datetime")


# Plot 3 (bottom left)
plot(x = housePower$Datetime,
     y = housePower$Sub_metering_1,
     type = "n",
     col = "black",
     ylab = "Energy sub metering",
     xlab = "")

lines(x = housePower$Datetime, y = housePower$Sub_metering_1, col = "black")
lines(x = housePower$Datetime, y = housePower$Sub_metering_2, col = "red")
lines(x = housePower$Datetime, y = housePower$Sub_metering_3, col = "blue")


# Plot 4 (bottom right)
plot(x = housePower$Datetime, 
     y = housePower$Global_reactive_power, 
     type = "l",
     col = "black",
     ylab = "Global_reactive_power",
     xlab = "datetime")