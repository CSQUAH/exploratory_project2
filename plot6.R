options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)
library(reshape2)
library(dplyr)

## rds files saved to local directory
if(!exists("NEI")){ NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")){ SCC <- readRDS("Source_Classification_Code.rds")}

## merge NEI & SCC data
if(!exists("NEISCC")){NEISCC <- merge(NEI,SCC,by="SCC")}

## subset Baltimore fips 24510, fips 06037(LA) and type=="ON-ROAD"
dataOnroadBalLA <- subset(NEISCC,(fips=="24510"|fips=="06037") & type=="ON-ROAD") 

## melting data
meltdata <- melt(dataOnroadBalLA,id=c("year","fips"),measure.vars="Emissions")

## reshape data sum by fips then year

data <- dcast(meltdata,fips+year~ variable,sum)
data <- mutate(data,City=ifelse(fips=="06037","Los Angeles",ifelse(fips=="24510","Baltimore","NA")))

##  plot graph
png('plot6.png')
g <- ggplot(data,aes(year,Emissions,color=City))
g <- g+geom_line()+xlab("year")+ylab("Total_PM2.5_Emissions")+ggtitle('PM2.5 Emission  trend comparison for Baltimore City-24510 and LA -06037(1999-2008)')

print(g)

dev.off()
