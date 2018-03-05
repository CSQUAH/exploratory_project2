options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)
##library(dplyr)

## rds files saved to local directory
if(!exists("NEI")){ NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")){ SCC <- readRDS("Source_Classification_Code.rds")}

## merge NEI & SCC data
if(!exists("NEISCC")){NEISCC <- merge(NEI,SCC,by="SCC")}

## filter contain coal
subsetcoal <- NEISCC[grepl('coal',NEISCC$Short.Name, ignore.case=TRUE),]

data <- aggregate(Emissions~ year,subsetcoal,FUN=sum)

##  plot graph
png('plot4.png')

g <- ggplot(data,aes(x=factor(year),y=Emissions))
g <- g+geom_bar(stat="identity")+xlab("year")+ylab("Total_PM2.5_Emissions")+ggtitle('PM2.5 Emission by coal (1999-2008)')
print(g)

dev.off()
