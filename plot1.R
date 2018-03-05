options(scipen=999)  # turn off scientific notation like 1e+06
## rds files saved to local directory
if(!exists("NEI")){ NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")){ SCC <- readRDS("Source_Classification_Code.rds")}
## aggregating the values to sum for each year
data1 <- aggregate(NEI$Emissions,by=list(NEI$year),FUN=sum)
names(data1) <- c("year","PM2.5_Ttl_Emission")
## direct plot
png('plot1.png')
barplot(height=data1$PM2.5_Ttl_Emission,names.arg = data1$year,xlab="year",ylab="PM2.5 Total Emission",main="Total PM2.5 emissions (1999-2008)")
##dev.copy(png,'plot1.png')
dev.off()
