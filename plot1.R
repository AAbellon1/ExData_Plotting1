df = read.table('./household_power_consumption.txt',sep=';',header=TRUE)

# Subsetting and formatting data
df$Date = as.Date(df$Date,'%d/%m/%Y')
df = df[which(df$Date >= '2007-02-01' & df$Date <= '2007-02-02'),]
df$Global_active_power = as.numeric(df$Global_active_power)

# Creating the plot
options(scipen=999)
hist(df$Global_active_power,col='red',main='Global Active Power',
     xlab='Global Active Power (kilowatts)')

# Converting into PNG
dev.copy(png,file='plot1.png',width=480,height=480,units='px')
dev.off()