options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)
##library(dplyr)

## rds files saved to local directory
if(!exists("NEI")){ NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")){ SCC <- readRDS("Source_Classification_Code.rds")}

## merge NEI & SCC data
if(!exists("NEISCC")){NEISCC <- merge(NEI,SCC,by="SCC")}

## subset Baltimore fips 24510 and type=="ON-ROAD"
BaltimoreMotor <- subset(NEISCC,fips=="24510" & type=="ON-ROAD") 

data <- aggregate(Emissions~ year,BaltimoreMotor,FUN=sum)

##  plot graph
png('plot5.png')

g <- ggplot(data,aes(x=factor(year),y=Emissions))
g <- g+geom_bar(stat="identity")+xlab("year")+ylab("Total_PM2.5_Emissions")+ggtitle('PM2.5 Emission by Motor Vehicles in Baltimore City (1999-2008)')
print(g)

dev.off()
