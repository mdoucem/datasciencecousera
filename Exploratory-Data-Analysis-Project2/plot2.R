# Read in the data
NEI <- readRDS("EmmissionsData/summarySCC_PM25.rds")
SCC <- readRDS("EmmissionsData/Source_Classification_Code.rds")

# Load the necessary libraries
library(dplyr)
library(ggplot2)

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

maryland_data<-filter(NEI, fips == "24510")

maryland_emissions<-aggregate(Emissions ~ year, maryland_data, sum)
png("plot2.png", width=480, height=480)
plot(maryland_emissions$year, maryland_emissions$Emissions, type = "l", 
     xlab = "Year", ylab = "Total PM2.5 Emissions")
title("Total PM2.5 Emissions in Baltimore City, Maryland from 1999 to 2008")
dev.off()