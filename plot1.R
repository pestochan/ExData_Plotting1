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

#read in the dataset
powerconsump <- fread("household_power_consumption.txt")

#combine date and time into one column
powerconsump$datetime <- paste(powerconsump$Date, powerconsump$Time, sep = " ")

#subset to the two dates
powerconsump$Date <- as.Date(powerconsump$Date, format = "%d/%m/%Y")
ourdates <- powerconsump[powerconsump$Date == "2007-02-01" | powerconsump$Date == "2007-02-02",]

#convert date time
ourdates$datetime <- dmy_hms(ourdates$datetime)

#make the first plot
hist(as.numeric(ourdates$Global_active_power),
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power",
     col  = "red")

#save to png. 
dev.copy(png, file = "plot1.png")
dev.off()

