url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "hpc.zip")
unzip("hpc.zip")

# Minutes per 2 days (indicates how many lines we need to read)
minutes <- 60*24*2
filename <- "household_power_consumption.txt"
hpc <- read.table(filename, sep = ";", header = FALSE,
                  skip=grep("31/1/2007;23:59:00;", readLines(filename)),
                  nrows = minutes)
hpc.names <- read.table(filename, sep = ";", nrows=1, stringsAsFactors = FALSE)
colnames(hpc) <- hpc.names
datetime <- paste(hpc$Date, hpc$Time)
hpc$datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot1.png")
hist(hpc$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global active power")
dev.off()