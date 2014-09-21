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

#Filter data 
Baltimore_Cali_data <- NEI[NEI$fips == "24510" |NEI$fips == "06037", ] 


motor <- grep("motor", SCC$Short.Name, ignore.case = T)
motor <- SCC[motor, ]
motor <- Baltimore_Cali_data [Baltimore_Cali_data$SCC %in% motor$SCC, ]

##Calculate the total emissions
motorEmissions <- aggregate(motor$Emissions, list(motor$year), FUN = "sum")

par("mar"=c(5.1, 4.5, 4.1, 2.1))

##Open graphical device
png(filename = "plot6.png",width = 480, height = 480,units = "px")

#Plot 6 :Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##Which city has seen greater changes over time in motor vehicle emissions

g <- ggplot(motor, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y = "sum") + geom_point(stat = "summary", fun.y = "sum") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Comparison of Total Emissions From Motor\n Vehicle Sources in Baltimore City\n and Los Angeles County from 1999 to 2008") +
  scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))
##Close Graphical Device
dev.off()