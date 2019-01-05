plot3 <- function(){
    # Loading the data...
    data <- fread("household_power_consumption.txt",na.strings = "?")
    
    # Filtering the data, first transforming the dates and then filtering for February 1 and 2
    filteredData <- data %>% transform(Date=as.Date(Date,"%d/%m/%Y")) %>% filter(Date=="2007-02-01"|Date=="2007-02-02")
    
    # Adding a new column called datetime for easy usage in plotting
    mutatedData <- filteredData %>% mutate(datetime=as.POSIXct(paste(Date,Time)))
    
    # Assinging title as variable for reusing it later with paste0 on x label
    title <- "Global Active Power"
    
    # Plotting mutatedData using with command with 3 concatenated parameters, each one with the sub_metering_n 
    # Removing default xlabel by assinging it to ""
    with(mutatedData,c(plot(datetime,Sub_metering_1,main=title,type="l",xlab = "",ylab = paste0(title," (kilowatts)")),
                       lines(datetime,Sub_metering_2,col="red"),
                       lines(datetime,Sub_metering_3,col="blue")))
    
    # Adding the legend with the line type 1 for the 3 colors (black,red and blue) and the legends with the titles
    legend("topright",lty=c(1,1,1),col=c("black","red","blue"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
    # Creating plot3.png by copying to the graphic device
    dev.copy(png,'plot3.png')
    dev.off()
}