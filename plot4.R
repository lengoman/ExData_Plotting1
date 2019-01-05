plot4 <- function(){
    # Loading the data...
    data <- fread("household_power_consumption.txt",na.strings = "?")
    
    # Filtering the data, first transforming the dates and then filtering for February 1 and 2
    filteredData <- data %>% transform(Date=as.Date(Date,"%d/%m/%Y")) %>% filter(Date=="2007-02-01"|Date=="2007-02-02")
    
    # Adding a new column called datetime for easy usage in plotting
    mutatedData <- filteredData %>% mutate(datetime=as.POSIXct(paste(Date,Time)))
    
    # Setting a plot global parameter for displaying 2 rows with 2 columns
    par(mfrow=c(2,2))
    
    # Creating the first and second plots each one with their own columns for y (global_active_power, voltage)
    with(mutatedData,c(plot(datetime,Global_active_power,type="l",ylab="Global Active Power",xlab = ""),
                       plot(datetime,Voltage,type="l",ylab="Voltage")))
    
    # Creating the third plot with all sub metering with different colors
    with(mutatedData,c(plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"),
                       lines(datetime,Sub_metering_2,col="red"),
                       lines(datetime,Sub_metering_3,col="blue")))
    
    # Adding the legend to the third plot with the box.lwd as 0 for removing the box line
    legend("topright",lty=c(1,1,1),box.lwd="0",col=c("black","red","blue"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
    # Creating the fourth plot with datetime and global_reactive_power using type="l" for line
    with(mutatedData,plot(datetime,Global_reactive_power,type="l"))
    
    # Creating plot4.png by copying to the graphic device
    dev.copy(png,'plot4.png')
    dev.off()
}