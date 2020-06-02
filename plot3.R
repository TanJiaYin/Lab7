#set working directory
setwd("D:/Documents/WIE2003/Lab 7/")

library(data.table)

## Getting full dataset
DT<-fread("./household_power_consumption 2.txt", na.strings="?")

DT$Date <- as.Date(DT$Date, format="%d/%m/%Y")

## Subsetting the data
DT.filter <- subset(DT, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(DT)

## Converting dates
datetime <- paste(as.Date(DT.filter$Date), DT.filter$Time)
DT.filter$Datetime <- as.POSIXct(datetime)

#plot the graph with legends
with(DT.filter, {
  plot(Global_active_power~Datetime, type="l",col='Blue',
       ylab="Global Minute-Averaged Power", xlab="")
  lines(Global_reactive_power~Datetime,col='Green')
})
legend("topright", col=c("blue", "green"), lty=1, lwd=3,
       legend=c("Global Active Power", "Global Reactive Power"), cex = 0.5)

## output histogram to PNG
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()