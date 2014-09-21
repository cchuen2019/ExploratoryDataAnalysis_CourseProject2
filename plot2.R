##Set working directory
setwd("C:\\Users\\diablo\\Desktop\\Coursera\\ExploratoryDataAnalysis\\Assignment2")

#Load the necessary libraries
library(ggplot2)
library(RDS)
library(data.table)

##Read in the Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Preview the data
head(NEI)
head(SCC)

#Filter data to Baltimore city (Fips = 24510 )

NEI_filtered_data <- NEI[NEI$fips == "24510", ] 

##Preview Filtered Data
head(NEI_filtered_data)

par("mar"=c(5.1, 4.5, 4.1, 2.1))

##Open graphical device
png(filename = "plot2.png",width = 480, height = 480,units = "px")
##Calculate Total emissions
totalEmissions <- aggregate(NEI_filtered_data$Emissions, list(NEI_filtered_data$year), FUN = "sum")

#Plot 2 :Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008

plot(totalEmissions, type = "o", xlab = "Year", main = "Total Emissions in Baltimore City from 1999 to 2008",
     ylab = expression('Total PM'[2.5]*" Emission"))
##Close Graphical Device
dev.off()