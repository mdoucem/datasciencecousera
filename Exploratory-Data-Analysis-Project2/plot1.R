# Read in the data
NEI <- readRDS("EmmissionsData/summarySCC_PM25.rds")
SCC <- readRDS("EmmissionsData/Source_Classification_Code.rds")

# Load the necessary libraries
library(dplyr)
library(ggplot2)

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
totalEmissions<-aggregate(Emissions ~ year, NEI, sum)

png("plot1.png", width=480, height=480)
plot(totalEmissions$year, totalEmissions$Emissions, type = "l", 
     xlab = "Year", ylab = "Total PM2.5 Emissions")
title("Total PM2.5 Emissions in the United States from 1999 to 2008")
dev.off()