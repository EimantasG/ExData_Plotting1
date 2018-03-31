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

sub_metering <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colors <- c("black", "red", "blue")

png(filename = "plot3.png")
plot(hpc$datetime, hpc[,sub_metering[1]], type = "l", col = colors[1],
     xlab = "", ylab = "Energy sub metering")
lines(hpc$datetime, hpc[,sub_metering[2]], type = "l", col = colors[2])
lines(hpc$datetime, hpc[,sub_metering[3]], type = "l", col = colors[3])
legend("topright", legend = sub_metering, lty = 1, col = colors)
dev.off()