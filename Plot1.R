plot1 <- function(datapath){
        
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
        
## Open Graphics device:
        png(filename = "plot1.png")
        
## Create Histogram:
        hist(myDF$Global_active_power, breaks = 15, col = "red", 
             main = "Global Active Power", xlab = "Globa Active Power (kilowatts)")
        
## Close graphics device:
        dev.off()


}