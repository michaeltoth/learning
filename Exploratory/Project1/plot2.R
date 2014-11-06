# Exercise assumes you have downloaded and extracted the zip file
# and that household_power_consumption.txt is in the working directory

if ( !exists("housePower")) {
    housePower <- read.table(file = "household_power_consumption_dated.txt", 
        sep = ";", 
        header = TRUE)
        
    housePower$Datetime <- as.POSIXct(paste(housePower$Date, housePower$Time), 
        format = "%d/%m/%Y %H:%M:%S")
}


par(mfrow = c(1,1))
plot(x = housePower$Datetime, 
     y = housePower$Global_active_power, 
     type = "l",
     col = "black",
     ylab = "Global Active Power (kilowatts)")