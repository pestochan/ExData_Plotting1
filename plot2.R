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

#make the second plot
plot(ourdates$datetime, as.numeric(ourdates$Global_active_power),
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#save to png. 
dev.copy(png, file = "plot2.png")
dev.off()

