dateRange <- c("1/2/2007","2/2/2007")
# download ZIP file and read into a data frame
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
mydata <- read.csv(unz(temp, "household_power_consumption.txt"), sep = ";", quote="", na.strings="?")
unlink(temp)
# subset the data to the two-day period of interest
mydata2 <- subset(mydata, mydata$Date %in% dateRange)
# add a column using strptime
mydata2$timestamp <- strptime(paste(mydata2$Date, mydata2$Time), format="%d/%m/%Y %H:%M:%S")
# plot a line graph of global_active_power against the timestamp
plot(mydata2$Global_active_power ~ as.POSIXct(mydata2$timestamp), type="l", ylab="Global Active Power (kilowatts)", xlab="")
# now save it out to a file
dev.copy(png,"plot2.png", width = 480, height= 480, units = "px")
dev.off()