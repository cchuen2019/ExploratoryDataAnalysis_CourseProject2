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
coal <- grep("coal", SCC$Short.Name, ignore.case = T)
coal <- SCC[coal, ]
coal <- NEI[NEI$SCC %in% coal$SCC, ]

##Calculate the total emissions
coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")

par("mar"=c(5.1, 4.5, 4.1, 2.1))

##Open graphical device
png(filename = "plot4.png",width = 480, height = 480,units = "px")

#Plot 4 :Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008
plot(coalEmissions, type = "o", xlab = "Year",
     main = "Total Emissions From Coal Combustion-related\n Sources in the United States\n from 1999 to 2008",
     ylab = expression('Total PM'[2.5]*" Emission"))
##Close Graphical Device
dev.off()