plot2 <- function(){
  library(plyr)
  
  ##filepath <- paste( getwd(), "/exdata-data-household_power_consumption/hpc_small.txt", sep="")
  filepath <- paste( getwd(), "/exdata-data-household_power_consumption/household_power_consumption.txt", sep="")
  
  ##Carga de la tabla
  data <- read.table(file=filepath, header=TRUE, na.strings=c("?", "NA"), sep=";") ##,  nrows=10000)
  
  mydates <- as.Date(c("1/2/2007","2/2/2007"), "%d/%m/%Y")
  ##mydates <- as.Date(c("16/12/2006","17/12/2006"), "%d/%m/%Y")
  
  ##Filtrado por fechas
  x <- data[as.Date(data$Date, "%d/%m/%Y") >= mydates[1] & as.Date(data$Date, "%d/%m/%Y") <= mydates[2], ]

  
  xgraph <- (count(x, vars=c("Date", "Time", "Global_active_power")))
  
  xgraph$datetime <- paste(xgraph$Date, xgraph$Time, sep = " ") ##, format = "%d%m%Y %H:%M")
  
  xgraph$datetime <- strptime(xgraph$datetime, format="%d/%m/%Y %H:%M")
  
  ##Parámetros para guardar imagen
  png("./exdata-data-household_power_consumption/plot2.png",width=480,height=480)

  ##Gráfica
  plot(xgraph$datetime, na.omit(xgraph$Global_active_power), 
       ylab="Global Active Power (kilowatts)", xlab="", type="l" )

  dev.off()

  
}