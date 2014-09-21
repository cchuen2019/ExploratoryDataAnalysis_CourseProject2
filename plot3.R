##Set working directory
setwd("C:\\Users\\diablo\\Desktop\\Coursera\\ExploratoryDataAnalysis\\Assignment2")

#Load the necessary libraries
library(ggplot2)
library(RDS)
library(data.table)
library(plyr)

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
png(filename = "plot3.png",width = 480, height = 480,units = "px")

##Calculate Total emissions by types of sources
Aggregate_data <- ddply(NEI_filtered_data[NEI_filtered_data$fips == "24510", ],.(type,year), summarise,
               TotalEmissions = sum(Emissions))

##Preview  Aggregate_data
head(Aggregate_data)


#Plot 3 :Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##Which have seen increases in emissions from 1999-2008

ggplot(Aggregate_data, aes(year, TotalEmissions, colour = type)) +
   geom_line() + geom_point() +
   labs(title = "Total Emissions by Type in Baltimore",
   x = "Year", y = "Total Emissions")

##Close Graphical Device
dev.off()