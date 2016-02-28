source_data <- "./data/Source_Classification_Code.rds"
raw_data <- "./data/summarySCC_PM25.rds"
result_folder <- "./results"
result_file <- "./results/baltimore_vs_losangeles_vehicle_emissions.png"

# make sure we won't be writing to nowhere
if (!file.exists(result_folder)) { 
     dir.create(result_folder)
}

# get and process the data from the files
metadata <- readRDS(source_data)
pmdata <- readRDS(raw_data)

# whittle the data down to something more friendly
metadata <- metadata[,c(1,4)] #scc and ei.sector
pmdata <- pmdata[,c(1,2,4,6)] #scc, emissions, year
sectors <- c(
     "Mobile - On-Road Gasoline Light Duty Vehicles",
     "Mobile - On-Road Gasoline Heavy Duty Vehicles",
     "Mobile - On-Road Diesel Light Duty Vehicles",
     "Mobile - On-Road Diesel Heavy Duty Vehicles"
); # in lieu of complex regex for such a simple subset
pmdata <- pmdata[pmdata$fips %in% c("24510","06037"),]
pmdata <- pmdata[pmdata$SCC %in% metadata[metadata$EI.Sector %in% sectors,]$SCC,]
pmdata <- merge(pmdata,metadata,by="SCC")
pmdata <- within(pmdata, {
     city = as.factor(ifelse(fips=="24510", "Baltimore, MD", "Los Angeles, CA"))
})
pmdata$year <- as.factor(pmdata$year)

# plot it
library(ggplot2)
g <- ggplot(pmdata,aes(year,Emissions))
g + geom_bar(stat="identity",aes(fill=city), position="dodge") + ggtitle("PM2.5 Vehicular Emissions, Baltimore v. Los Angeles")
ggsave(result_file,units="in",dpi=72,width=7,height=5)

