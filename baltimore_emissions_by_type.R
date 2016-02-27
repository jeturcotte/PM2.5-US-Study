source_data <- "./data/Source_Classification_Code.rds"
raw_data <- "./data/summarySCC_PM25.rds"
result_folder <- "./results"
result_file <- "./results/baltimore_emissions_by_type.png"

# make sure we won't be writing to nowhere
if (!file.exists(result_folder)) { 
     dir.create(result_folder)
}

# get and process the data from the files
#source <- readRDS(source_data);
pmdata <- readRDS(raw_data);
pmdata <- pmdata[pmdata$fips=="24510",]
pmdata$year <- as.factor(pmdata$year)

# plot it
library(ggplot2)
#png(filename=result_file, width=480, height=480, units="px")
g <- ggplot(pmdata,aes(year,Emissions))
g + geom_bar(stat="identity",aes(fill=type), position="dodge") + ggtitle("Baltimore, MD PM2.5 Emissions by Type")
ggsave(result_file,units="in",dpi=72,width=6,height=5)
#dev.off()
