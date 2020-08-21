### 2020-08-21 ###

library(data.table)
library(lubridate)

#if the zipfolder file does not exist in the directory, download it; otherwise do nothing. 
zipfolder <- "power_consumption.zip"
if(!file.exists(zipfolder)){
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl, zipfolder, method = "curl")
}

#if the txt file does not exist in the directory, unzip to get it; otherwise do nothing. 
if(!file.exists("household_power_consumption.txt")){
        unzip(zipfolder)
}

#read in the dataset & subset to the two dates we want. 
powerconsump <- fread("household_power_consumption.txt")
ourdates <- powerconsump[powerconsump$Date == "1/2/2007" | powerconsump$Date == "2/2/2007",]

#combine date and time into one column
ourdates$datetime <- paste(ourdates$Date, ourdates$Time, sep = " ")

#convert date time
ourdates$datetime <- dmy_hms(ourdates$datetime)

#make the fourth plot
#set up the matrix
par(mfrow = c(2,2), mar = c(4,4,1,1))
#top left plot
plot(ourdates$datetime, as.numeric(ourdates$Global_active_power),
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

#top right plot
plot(ourdates$datetime, as.numeric(ourdates$Voltage),
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

#bottom left plot
plot(ourdates$datetime, as.numeric(ourdates$Sub_metering_1),
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
#add legend
legend("topright", 
       lty = 1,
       col    = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty = "n")
#add the three lines
lines(ourdates$datetime, as.numeric(ourdates$Sub_metering_1), col = "black")
lines(ourdates$datetime, as.numeric(ourdates$Sub_metering_2), col = "red")
lines(ourdates$datetime, as.numeric(ourdates$Sub_metering_3), col = "blue")

#bottom right plot
plot(ourdates$datetime, as.numeric(ourdates$Global_reactive_power),
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")


#save to png. 
dev.copy(png, file = "plot4.png")
dev.off()

