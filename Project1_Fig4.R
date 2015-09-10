## Build plots for project one in exploratory data analysis

# Set working directory to the location of the data file on your machine
setwd("C:/Users/USER/Dropbox/Coursera/Exploratory Data Analysis/Data")

# Read in the data, clean it up, and then reduce it to just Feb 1 and 2 of 2007
# stringsAsFactors = FALSE means everything is read in as characters, not factors

df <- read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE)
df$Date <- as.Date(df$Date, format = "%d/%m/20%y")
df$DateTime <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")
startTime <- as.POSIXlt("2007-02-01")
endTime <- as.POSIXlt("2007-02-03")

df <- subset(df, subset = (as.numeric(df$DateTime) >= as.numeric(startTime)) & 
                   (as.numeric(df$DateTime) < as.numeric(endTime)))

df$Global_active_power <- as.numeric(df$Global_active_power)

# Set working directory to desired output file location here
setwd("C:/Users/USER/Dropbox/Coursera/Exploratory Data Analysis/")
png(filename = "plot4.png")
par(mfrow = c(2,2))

plot(df$DateTime, df$Global_active_power, type="l", ylab = "Global Active Power", xlab="Time", main = "")

plot(df$DateTime, df$Voltage, type="l", ylab = "Voltage", xlab="Time")

plot(df$DateTime, df$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="Time")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")
legend("topright", 
       col=c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1)

plot(df$DateTime, df$Global_reactive_power, type="l", ylab = "Global Reactive Power", xlab="Time")
dev.off()