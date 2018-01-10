# Read in the data
NEI <- readRDS("EmmissionsData/summarySCC_PM25.rds")
SCC <- readRDS("EmmissionsData/Source_Classification_Code.rds")

# Load the necessary libraries
library(dplyr)
library(ggplot2)

# 3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

maryland_data<-filter(NEI, fips == "24510")

#first have to group the data by year, then type and get sum
maryland_grpemissions<-aggregate(Emissions ~ year + type, maryland_data, sum)

png("plot3.png", width=480, height=480)
ggplot(maryland_grpemissions, aes(year, Emissions, color = type)) +
  geom_line() + xlab("Year") + ylab("Emissions") +
  ggtitle("Total Emissions in Baltimore City, Maryland from 1999 to 2008 by Type")
dev.off()