# loading data from data file
data<-read.table("household_power_consumption.txt", header = TRUE, sep =";")
# subsetting data with specific dates:
data_sub<-data[which(data$"Date"=="1/2/2007"|data$"Date"=="2/2/2007"),]
# plotting data
# once loaded, Global_active_power is assumed to be of class level
# as.character converts class level into character, and as.numeric converts it to numerical values
png("plot1.png",width=480,height=480)
hist(as.numeric(as.character(data_sub$Global_active_power)),col="red",main = "Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()