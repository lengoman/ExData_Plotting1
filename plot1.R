plot1 <- function(){
    # Loading the data...
    data <- fread("household_power_consumption.txt",na.strings = "?")
    
    # Filtering the data, first transforming the dates and then filtering for February 1 and 2
    filteredData <- data %>% transform(Date=as.Date(Date,"%d/%m/%Y")) %>% filter(Date=="2007-02-01"|Date=="2007-02-02")
    
    # Assinging title as variable for reusing it later with paste0 on x label
    title <- "Global Active Power"
    
    # Plotting histogram with filtered data using with command with color as red and titles
    with(filteredData,hist(Global_active_power,col="red",main=title,xlab = paste0(title," (kilowatts)")))
    
    # Creating plot1.png by copying to the graphic device
    dev.copy(png,'plot1.png')
    dev.off()
}