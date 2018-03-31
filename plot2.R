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

png(filename = "plot2.png")
plot(hpc$datetime, hpc$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()