library(sqldf) ##Load sqldf library

## read 5 rows to get Column classes
input5 <- read.table('household_power_consumption.txt',header=TRUE,na.strings = "?", nrows = 5, sep=';')
classes <- sapply(input5,class)
## Read House Hole Power Consumption file only for 1/2/2007 and 2/2/2007
input <- read.csv.sql('household_power_consumption.txt',sep=';',colClasses = classes, header = TRUE, eol = '\n', sql = " select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")
## Add new Columne DateTime
input <- cbind(input,DateTime="")
## Merge Date and Time with Space as seperator
input$DateTime <- paste(input$Date,input$Time,sep=" ")

##Convert into Datetime Using strptime
input$DateTime <- strptime(input$DateTime, format='%d/%m/%Y %H:%M:%S')

#Plot
png("plot2.png",width=480,height=480,unit="px")
plot(input$DateTime,input$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)")

#Save Into Plot1.png
dev.off ()