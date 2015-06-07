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
# plot three line graphs of sub metering values against the timestamp

# this results in an unfortunate cut-off label in the PNG
plot(mydata2$Sub_metering_1 ~ as.POSIXct(mydata2$timestamp), type="l", ylab="Engergy sub metering",xlab="")
lines(mydata2$Sub_metering_2 ~ as.POSIXct(mydata2$timestamp), col="red")
lines(mydata2$Sub_metering_3 ~ as.POSIXct(mydata2$timestamp), col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1)
# now save it out to a file
dev.copy(png,"plot3.png", width = 480, height= 480, units = "px")
dev.off()

# I found this approach works better
png("plot3.png", width = 480, height= 480, units = "px")
plot(mydata2$Sub_metering_1 ~ as.POSIXct(mydata2$timestamp), type="l", ylab="Engergy sub metering",xlab="")
lines(mydata2$Sub_metering_2 ~ as.POSIXct(mydata2$timestamp), col="red")
lines(mydata2$Sub_metering_3 ~ as.POSIXct(mydata2$timestamp), col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1)
# now save it out to a file
dev.off()