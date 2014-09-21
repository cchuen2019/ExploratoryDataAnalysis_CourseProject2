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
Baltimore_data <- NEI[NEI$fips == "24510", ] 

motor <- grep("motor", SCC$Short.Name, ignore.case = T)
motor <- SCC[motor, ]
motor <- Baltimore_data[Baltimore_data$SCC %in% motor$SCC, ]

##Calculate the total emissions

motorEmissions <- aggregate(motor$Emissions, list(motor$year), FUN = "sum")

par("mar"=c(5.1, 4.5, 4.1, 2.1))

##Open graphical device
png(filename = "plot5.png",width = 480, height = 480,units = "px")

#Plot 5 :How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

plot(motorEmissions, type = "o", xlab = "Year",
     main = "Total Emissions From Motor Vehicle Sources\n from 1999 to 2008 in Baltimore City",
     ylab = expression('Total PM'[2.5]*" Emission"))

##Close Graphical Device
dev.off()