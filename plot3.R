plot3 <- function(){
  library(plyr)
  
  ##filepath <- paste( getwd(), "/exdata-data-household_power_consumption/hpc_small.txt", sep="")
  filepath <- paste( getwd(), "/exdata-data-household_power_consumption/household_power_consumption.txt", sep="")
  
  ##Carga de la tabla
  data <- read.table(file=filepath, header=TRUE, na.strings=c("?", "NA"), sep=";") ##,  nrows=10000)
  
  mydates <- as.Date(c("1/2/2007","2/2/2007"), "%d/%m/%Y")
  ##mydates <- as.Date(c("16/12/2006","17/12/2006"), "%d/%m/%Y")
  
  ##Filtrado por fechas
  x <- data[as.Date(data$Date, "%d/%m/%Y") >= mydates[1] & as.Date(data$Date, "%d/%m/%Y") <= mydates[2], ]
  
  xgraph <- (count(x, vars=c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")))
  
  xgraph$datetime <- paste(xgraph$Date, xgraph$Time, sep = " ") ##, format = "%d%m%Y %H:%M")
  
  xgraph$datetime <- strptime(xgraph$datetime, format="%d/%m/%Y %H:%M")
  
    
  ##Parámetros para guardar imagen
  
  
  colors <- c("black","red","blue")
  
  png("./exdata-data-household_power_consumption/plot3.png")
  ##dev.off()
  
  ##x11()
  ##Gráfica
  plot(xgraph$datetime, na.omit(xgraph$Sub_metering_1), 
       ylab="Energy sub metering", xlab="", type="l", col=colors[1])
  lines(xgraph$datetime, na.omit(xgraph$Sub_metering_2), col=colors[2])
  lines(xgraph$datetime, na.omit(xgraph$Sub_metering_3), col=colors[3])
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col=colors, lty=c(1,1), bty="n")
  
  ##legend(x=100,y=100,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1))
  
  dev.off()
  
  
}