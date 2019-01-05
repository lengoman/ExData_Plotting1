plot2 <- function(){
    # Loading the data...
    data <- fread("household_power_consumption.txt",na.strings = "?")
    
    # Filtering the data, first transforming the dates and then filtering for February 1 and 2
    filteredData <- data %>% transform(Date=as.Date(Date,"%d/%m/%Y")) %>% filter(Date=="2007-02-01"|Date=="2007-02-02")
    
    # Adding a new column called datetime for easy usage in plotting
    mutatedData <- filteredData %>% mutate(datetime=as.POSIXct(paste(Date,Time)))
    
    # Assinging title as variable for reusing it later with paste0 on x label
    title <- "Global Active Power"
    
    # Plotting mutated data (data with new column datetime) and using datetime with global_active_power column
    with(mutatedData,plot(datetime,Global_active_power,main=title,type="l",xlab = "",ylab = paste0(title," (kilowatts)")))
    
    # Creating plot2.png by copying to the graphic device
    dev.copy(png,'plot2.png')
    dev.off()
}