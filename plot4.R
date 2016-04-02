plot4 <- function(datapath){
        
## Check, INstall and load libraries:
        
        packages <- c("sqldf")
        if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
                install.packages(setdiff(packages, rownames(installed.packages())))  
        }
        library(sqldf)
        
## Set WD to datapath: 
        setwd(datapath)
        
## Read while subsetting the file:
        myDF <- read.csv.sql("household_power_consumption.txt",
        sql = "select * from file where Date='1/2/2007' OR Date='2/2/2007' ", 
        header = TRUE, sep = ";", row.names = NULL,
        colClasses = c("Date", "factor", "numeric", "numeric", "numeric", 
        "numeric", "numeric", "numeric", "numeric"))

## Create Posix object:
        mytime <- strptime(paste(myDF$Date, myDF$Time), format="%d/%m/%Y %H:%M:%S")
        
## Open Graphics device:
        png(filename = "plot4.png")
        
## Create plots:
        ## 4 plots:
        par(mfrow = c(2, 2))
        
        ## Plot 1:
        plot(x = mytime , y = myDF$Global_active_power, type = "l",
             ylab="Global Active Power (kilowatts)", xlab="")
        
        ## Plot 2:
        plot(x = mytime , y = myDF$Voltage, type = "l",
             ylab="Voltage", xlab="datetime")
        
        ## Plot 3:
        
                ## Select position so it overlays the lines:
        par(mfg = c(2, 1))
        
                ## And construct the plot:
        plot(x = mytime , y = myDF$Sub_metering_1, type = "l",
             ylab="Energy sub metering", xlab="")
        lines(x = mytime, y = myDF$Sub_metering_2, col = "red")
        lines(x = mytime, y = myDF$Sub_metering_3, col = "blue")
        legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                        "Sub_metering_3"), col = c("black", "red", "blue"),
                        lty = c(1, 1, 1))
        
        ## Plot 4:
        
                ##Specifiy next plot so it does not overwrite #3:
        par(mfg = c(2, 2))
        plot(x = mytime , y = myDF$Global_reactive_power, type = "l",
             ylab="Global_reactive_power", xlab="datetime")
        
        
## Close graphics device:
        dev.off()

}