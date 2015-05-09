# loading data from data file
data<-read.table("household_power_consumption.txt", header = TRUE, sep =";")
# subsetting data with specific dates:
data_sub<-data[which(data$"Date"=="1/2/2007"|data$"Date"=="2/2/2007"),]
# cleaning x variable:
date <- as.character(data_sub$Date)
time <- as.character(data_sub$Time)
dateTime <- strptime(paste(date,time), "%d/%m/%Y %H:%M:%S")
# cleaning y variable:
Power_ac <- as.numeric(as.character(data_sub$Global_active_power))

Voltage <- as.numeric(as.character(data_sub$Voltage))

y1 <- as.numeric(as.character(data_sub$Sub_metering_1))
y2 <- as.numeric(as.character(data_sub$Sub_metering_2))
y3 <- as.numeric(as.character(data_sub$Sub_metering_3))

Power_rac <- as.numeric(as.character(data_sub$Global_reactive_power))
# plot
png("plot4.png",width=480,height=480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(dateTime,Power_ac,type = "l", col="black",xlab="",ylab="Global Active Power")
plot(dateTime,Voltage,type = "l", col="black",xlab="datetime",ylab="Voltage")
plot(dateTime,y1,type="l",col="black",ylab="Energy sub metering",xlab="")
lines(dateTime,y2,type="l",col="red")
lines(dateTime,y3,type="l",col="blue")
legend("topright",lty="solid",col=c("black","red","blue"),legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),bty="n")
plot(dateTime,Power_rac,type = "l", col="black",xlab="datetime",ylab="Global_reactive_power")
dev.off()