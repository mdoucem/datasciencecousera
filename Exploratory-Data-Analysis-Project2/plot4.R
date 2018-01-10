# Read in the data
NEI <- readRDS("EmmissionsData/summarySCC_PM25.rds")
SCC <- readRDS("EmmissionsData/Source_Classification_Code.rds")

# Load the necessary libraries
library(dplyr)
library(ggplot2)

# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# Let's first merge the data
merged_NEI_SCC<-merge(NEI, SCC, by="SCC")
coal_data<-filter(merged_NEI_SCC, grepl('coal', Short.Name, ignore.case = TRUE))
coal_emissions<-aggregate(Emissions ~ year, coal_data, sum)

png("plot4.png", width=480, height=480)
plot(coal_emissions$year,coal_emissions$Emissions, type = "l", 
     xlab = "Year", ylab = "Total Coal Emissions")
title("Total Coal Emissions in USA from 1999 to 2008")
dev.off()