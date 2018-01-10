# Read in the data
NEI <- readRDS("EmmissionsData/summarySCC_PM25.rds")
SCC <- readRDS("EmmissionsData/Source_Classification_Code.rds")

# Load the necessary libraries
library(dplyr)
library(ggplot2)

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

#Baltimore data
road_baltimore_data<-filter(NEI, fips=="24510" & type=="ON-ROAD")
road_baltimore_emissions<-aggregate(Emissions ~ year, road_baltimore_data, sum)

# LA data
road_LA_data<-filter(NEI, fips=="06037" & type=="ON-ROAD")
road_LA_emissions<-aggregate(Emissions ~ year, road_LA_data, sum)

total_emissions<-cbind(road_baltimore_emissions, road_LA_emissions$Emissions)
colnames(total_emissions)<-c("year", "Baltimore_emissions", "LA_emissions")

# Create and save file
png("plot6.png", width=480, height=480)
ggplot(total_emissions) + geom_line(aes(x=year, y=Baltimore_emissions, col="Baltimore")) +
  geom_line(aes(x=year, y=LA_emissions, col = "LA")) +
  xlab("Year") + ylab("Emissions") +
  ggtitle("Total Emissions in Baltimore and LA from 1999 to 2008 by Type")
dev.off()