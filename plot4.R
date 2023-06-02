df = read.table('./household_power_consumption.txt',sep=';',header=TRUE)

# Subsetting and formatting data
df$Date = as.Date(df$Date,'%d/%m/%Y')
df = df[which(df$Date >= '2007-02-01' & df$Date <= '2007-02-02'),]
df$Global_active_power = as.numeric(df$Global_active_power)
df$Sub_metering_1 = as.numeric(df$Sub_metering_1)
df$Sub_metering_2 = as.numeric(df$Sub_metering_2)
df$Sub_metering_3 = as.numeric(df$Sub_metering_3)
df$Voltage = as.numeric(df$Voltage)
df$Global_reactive_power = as.numeric(df$Global_reactive_power)
df$dateTime = paste(df$Date,df$Time)
df$dateTime = as.POSIXct(df$dateTime,tz='','%Y-%m-%d %H:%M:%S')

# Creating the plot
par(mfcol = c(2,2))

options(scipen=999)
plot(df$dateTime,df$Global_active_power,type='l',xaxt='n',
         xlab='dateTime',ylab='Global Active Power (kilowatts)')
axis(1,at=c(df[which(df$Time == '00:00:00'),'dateTime'],
            df[nrow(df),'dateTime']),
     labels=c(strftime(df[which(df$Time == '00:00:00')[1],'Date'],'%a'),
                  strftime(df[which(df$Time == '00:00:00')[2],'Date'],'%a'),
                  strftime(df[nrow(df),'Date']+1,'%a')))
    
options(scipen=999)
plot(df$dateTime,df$Sub_metering_1,xlab='dateTime',
     ylab='Energy sub metering',type='l',xaxt='n')
lines(df$dateTime,df$Sub_metering_2,col='red')
lines(df$dateTime,df$Sub_metering_3,col='blue')
legend('top',col=c('black','red','blue'),
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty=1,x.intersp=0.5, y.intersp=0.5,bty='n',xjust=1,cex=0.8)
axis(1,at=c(df[which(df$Time == '00:00:00'),'dateTime'],
            df[nrow(df),'dateTime']),
     labels=c(strftime(df[which(df$Time == '00:00:00')[1],'Date'],'%a'),
              strftime(df[which(df$Time == '00:00:00')[2],'Date'],'%a'),
              strftime(df[nrow(df),'Date']+1,'%a')))

options(scipen=999)
plot(df$dateTime,df$Voltage,type='l',xaxt='n',
     xlab='dateTime',ylab='Voltage')
axis(1,at=c(df[which(df$Time == '00:00:00'),'dateTime'],
            df[nrow(df),'dateTime']),
     labels=c(strftime(df[which(df$Time == '00:00:00')[1],'Date'],'%a'),
              strftime(df[which(df$Time == '00:00:00')[2],'Date'],'%a'),
              strftime(df[nrow(df),'Date']+1,'%a')))

options(scipen=999)
plot(df$dateTime,df$Global_reactive_power,type='l',xaxt='n',
     xlab='dateTime',ylab='Global_reactive_power')
axis(1,at=c(df[which(df$Time == '00:00:00'),'dateTime'],
            df[nrow(df),'dateTime']),
     labels=c(strftime(df[which(df$Time == '00:00:00')[1],'Date'],'%a'),
              strftime(df[which(df$Time == '00:00:00')[2],'Date'],'%a'),
              strftime(df[nrow(df),'Date']+1,'%a')))

# Converting into PNG
dev.copy(png,file='plot4.png',width=480,height=480,units='px')
dev.off()