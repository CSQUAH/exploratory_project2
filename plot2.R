options(scipen=999)  # turn off scientific notation like 1e+06

## rds files saved to local directory
if(!exists("NEI")){ NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")){ SCC <- readRDS("Source_Classification_Code.rds")}

## subsetting baltimore data
dataBaltimore <- subset(NEI,fips=="24510")
## aggregating the values to sum for each year

data1 <- aggregate(dataBaltimore$Emissions,by=list(dataBaltimore$year),FUN=sum)
names(data1) <- c("year","PM2.5_Ttl_Emission")
##  plot graph
png('plot2.png')
barplot(height=data1$PM2.5_Ttl_Emission,names.arg = data1$year,xlab="year",ylab="PM2.5 Total Emission",main="Baltimore Total PM2.5 emissions (1999-2008)")
dev.off()
