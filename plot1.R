plot1 <- function(){
  library(plyr)
  
  ##Ruta del archivo
  filepath <- paste( getwd(), "/exdata-data-household_power_consumption/household_power_consumption.txt", sep="")
  
  ##Leo el archivo y convierto "?" en "NA"
  data <- read.table(file=filepath, header=TRUE, na.strings=c("?", "NA"), sep=";") 
  
  ##Arreglo de fechas
  mydates <- as.Date(c("1/2/2007","2/2/2007"), "%d/%m/%Y")
  
  ##Frame de datos
  xgraph <- data[as.Date(data$Date, "%d/%m/%Y") >= mydates[1] & as.Date(data$Date, "%d/%m/%Y") <= mydates[2], ]
  ##xdata <- data[data$Date >= mydates[1] & data$Date <= mydates[2], ]
  
  ##Parámetros para guardar imagen
  png("./exdata-data-household_power_consumption/plot1.png",width=480,height=480)
  
  ##Genera gráfica
  hist(na.omit(xgraph$Global_active_power), plot=TRUE, col="red",
       main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off()

  
}