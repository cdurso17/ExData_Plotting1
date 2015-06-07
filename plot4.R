#######################################################################
# Read in household power consumption data and generate exploratory 
# plots for 1/2/2007-2/2/2007
#######################################################################

#### Read in the data.

### Locate required rows once.
#dat<-read.table("household_power_consumption.txt",header=TRUE,sep=";",
#	na.string="?")
#begin_row<-min(which(dat$Date %in% c("1/2/2007","2/2/2007"))) # 66637
#end_row<-max(which(dat$Date %in% c("1/2/2007","2/2/2007"))) # 69516

diff<-69516-66637+1 # number of data rows necessary

### Read header information into a string vector
name_str<-readLines("household_power_consumption.txt",n=1)
name_str<-unlist(strsplit(name_str,";"))

### Read data into a data.frame: "trim".
trim<-read.table("household_power_consumption.txt",sep=";",skip=66637,nrow=diff,
	stringsAsFactors = FALSE,na.string="?")
names(trim)<-name_str

### Construct a datetime variable from trim$Date amd trim$Time
datetime<-paste(trim$Date,trim$Time)
datetime<-strptime(datetime, format="%d/%m/%Y %H:%M:%S")
trim$datetime<-datetime

### Plot multiple exploratory graphs for the two days in one device.
png(file="plot4.png")
par(mfrow=c(2,2))
with(trim,plot(datetime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",
	xlab=""))

with(trim,plot(datetime,Voltage,type="l"))

with(trim,plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering",
	xlab=""))
with(trim,points(datetime,Sub_metering_2,type="l",col="red"))
with(trim,points(datetime,Sub_metering_3,type="l",col="blue"))
legend("topright",col=c("black","red","blue"), legend=names(trim)[7:9],lty=1,
	bty="n")


with(trim,plot(datetime,Global_reactive_power,type="l"))


dev.off()

