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

#Filter data to specific years

filter_Years <- c('1999','2002','2005','2008')
NEI_filtered_data <- NEI[NEI$year==filter_Years,]

##Preview Filtered Data
head(NEI_filtered_data)

##Calculate Total emissions
totalEmissions <- aggregate(NEI_filtered_data$Emissions, list(NEI_filtered_data$year), FUN = "sum")


par("mar"=c(5.1, 4.5, 4.1, 2.1))

##Open graphical device
png(filename = "plot1.png",width = 480, height = 480,units = "px")


#Plot 1 :Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? U
##Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

plot(totalEmissions, type = "o", xlab = "Year", main = "Total PM 2.5 Emissions in the United States\n from 1999 to 2008",
     ylab = expression('Total PM'[2.5]*" Emission"))

##Close Graphical Device
dev.off()