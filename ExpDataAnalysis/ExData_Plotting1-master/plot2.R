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
# plotting data
png("plot2.png",width=480,height=480)
plot(dateTime,Power_ac,type = "l", col="black",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
