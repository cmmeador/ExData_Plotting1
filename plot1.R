dateRange <- c("1/2/2007","2/2/2007")
# download ZIP file and read into a data frame
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
mydata <- read.csv(unz(temp, "household_power_consumption.txt"), sep = ";", quote="", na.strings="?")
unlink(temp)
# subset the data to the two-day period of interest
mydata2 <- subset(mydata, mydata$Date %in% dateRange)
# construct our histogram in default device (screen)
hist(mydata2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylim=c(0,1200))
# now save it out to a file
dev.copy(png,"plot1.png", width = 480, height= 480, units = "px")
dev.off()
