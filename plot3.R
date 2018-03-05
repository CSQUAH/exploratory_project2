options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)

## rds files saved to local directory
if(!exists("NEI")){ NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")){ SCC <- readRDS("Source_Classification_Code.rds")}

## subsetting baltimore data
dataBaltimore <- subset(NEI,fips=="24510")
## aggregating the values to sum for each year

data <- aggregate(Emissions~ year+type,dataBaltimore,FUN=sum)

##  plot graph
png('plot3.png')

g <- ggplot(data,aes(year,Emissions,color=type))
g <- g+geom_line()+xlab("year")+ylab("Total_PM2.5_Emissions")+ggtitle('PM2.5 Emission sources trend in Baltimore City (1999-2008)')
print(g)

dev.off()
