# loading data from data file
data<-read.table("household_power_consumption.txt", header = TRUE, sep =";")
# subsetting data with specific dates:
data_sub<-data[which(data$"Date"=="1/2/2007"|data$"Date"=="2/2/2007"),]
# cleaning x variable:
date <- as.character(data_sub$Date)
time <- as.character(data_sub$Time)
dateTime <- strptime(paste(date,time), "%d/%m/%Y %H:%M:%S")
# cleaning y variable:
y1 <- as.numeric(as.character(data_sub$Sub_metering_1))
y2 <- as.numeric(as.character(data_sub$Sub_metering_2))
y3 <- as.numeric(as.character(data_sub$Sub_metering_3))
# plot
png("plot3.png",width=480,height=480)
plot(dateTime,y1,type="l",col="black",ylab="Energy sub metering",xlab="")
lines(dateTime,y2,type="l",col="red")
lines(dateTime,y3,type="l",col="blue")
legend("topright",lty="solid",col=c("black","red","blue"),legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))
dev.off()