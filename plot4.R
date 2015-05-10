plot4 <- function(){
  library(plyr)
  ##filepath <- paste( getwd(), "/exdata-data-household_power_consumption/hpc_small.txt", sep="")
  filepath <- paste( getwd(), "/exdata-data-household_power_consumption/household_power_consumption.txt", sep="")
  
  ##Carga de la tabla
  data <- read.table(file=filepath, header=TRUE, na.strings=c("?", "NA"), sep=";") ##,  nrows=10000)
  
  mydates <- as.Date(c("1/2/2007","2/2/2007"), "%d/%m/%Y")
  ##mydates <- as.Date(c("16/12/2006","17/12/2006"), "%d/%m/%Y")
  
  ##Filtrado por fechas
  x <- data[as.Date(data$Date, "%d/%m/%Y") >= mydates[1] & as.Date(data$Date, "%d/%m/%Y") <= mydates[2], ]
  
  xgraph <- (count(x, vars=c("Date", "Time", "Global_active_power","Global_reactive_power", 
                             "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", 
                             "Voltage")))
  
  xgraph$datetime <- paste(xgraph$Date, xgraph$Time, sep = " ") ##, format = "%d%m%Y %H:%M")
  
  xgraph$datetime <- strptime(xgraph$datetime, format="%d/%m/%Y %H:%M")
  
  ##Parámetros para guardar imagen
  png("./exdata-data-household_power_consumption/plot4.png",width=480,height=480)
  
  colors <- c("black","red","blue")
  
  ##op=par(mfrow=c(3,1), mar=c(1,1,1,1))
  par(mfrow=c(2,2))
  ##Gráfica 1
  plot(xgraph$datetime, na.omit(xgraph$Global_active_power), 
       ylab="Global Active Power (kilowatts)", xlab="", type="l", col=colors[1] )
  
  ##Gráfica 3
  plot(xgraph$datetime, na.omit(xgraph$Voltage), 
       ylab="Voltage", xlab="datetime", type="l", col=colors[1])
  
  ##Gráfica 2
  plot(xgraph$datetime, na.omit(xgraph$Sub_metering_1), 
       ylab="Energy sub metering", xlab="", type="l", col=colors[1])
  lines(xgraph$datetime, na.omit(xgraph$Sub_metering_2), col=colors[2])
  lines(xgraph$datetime, na.omit(xgraph$Sub_metering_3), col=colors[3])
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col=colors, lty=c(1,1), bty="n")
  
  
  ##Gráfica 4
  plot(xgraph$datetime, na.omit(xgraph$Global_reactive_power), 
       ylab="Global Reactive Power", xlab="datetime", type="l", col=colors[1])
  
  dev.off()
  
  
}