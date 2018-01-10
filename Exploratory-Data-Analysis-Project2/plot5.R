# Read in the data
NEI <- readRDS("EmmissionsData/summarySCC_PM25.rds")
SCC <- readRDS("EmmissionsData/Source_Classification_Code.rds")

# Load the necessary libraries
library(dplyr)
library(ggplot2)

# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
road_baltimore_data<-filter(NEI, fips=="24510" & type=="ON-ROAD")
road_baltimore_emissions<-aggregate(Emissions ~ year, road_baltimore_data, sum)

# Create and save file
png("plot5.png", width=480, height=480)
plot(road_baltimore_emissions$year,road_baltimore_emissions$Emissions, type = "l", 
     xlab = "Year", ylab = "Total Motor Vehicle Emissions")
title("Total On-Road Emissions in Baltimore from 1999 to 2008")
dev.off()
