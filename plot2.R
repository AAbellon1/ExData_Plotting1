df = read.table('./household_power_consumption.txt',sep=';',header=TRUE)

# Subsetting and formatting data
df$Date = as.Date(df$Date,'%d/%m/%Y')
df = df[which(df$Date >= '2007-02-01' & df$Date <= '2007-02-02'),]
df$Global_active_power = as.numeric(df$Global_active_power)
df$dateTime = paste(df$Date,df$Time)
df$dateTime = as.POSIXct(df$dateTime,tz='','%Y-%m-%d %H:%M:%S')

# Creating the plot
options(scipen=999)
plot(df$dateTime,df$Global_active_power,type='l',xaxt='n',
     xlab='dateTime',ylab='Global Active Power (kilowatts)')
axis(1,at=c(df[which(df$Time == '00:00:00'),'dateTime'],
            df[nrow(df),'dateTime']),
     labels=c(strftime(df[which(df$Time == '00:00:00')[1],'Date'],'%a'),
              strftime(df[which(df$Time == '00:00:00')[2],'Date'],'%a'),
              strftime(df[nrow(df),'Date']+1,'%a')))

# Converting into PNG
dev.copy(png,file='plot2.png',width=480,height=480,units='px')
dev.off()