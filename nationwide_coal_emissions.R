source_data <- "./data/Source_Classification_Code.rds";
raw_data <- "./data/summarySCC_PM25.rds";
result_folder <- "./results";
result_file <- "./results/nationwide_coal_emissions.png";

# make sure we won't be writing to nowhere
if (!file.exists(result_folder)) { 
     dir.create(result_folder);
}

# get and process the data from the files
metadata <- readRDS(source_data)
pmdata <- readRDS(raw_data)

# whittle the data down to something more friendly
metadata <- metadata[,c(1,4)] #scc and ei.sector
pmdata <- pmdata[,c(2,4,6)] #scc, emissions, year
pmdata <- pmdata[pmdata$SCC %in% metadata[grepl("coal",metadata$EI.Sector,ignore.case=TRUE),]$SCC,]
pmdata <- merge(pmdata,metadata,by="SCC")
pmdata$year <- as.factor(pmdata$year)

# plot it
library(ggplot2)
g <- ggplot(pmdata,aes(year,Emissions))
g + geom_bar(stat="identity",aes(fill=EI.Sector), position="dodge") + ggtitle("Nationwide Coal PM2.5 Emissions by Sector")
ggsave(result_file,units="in",dpi=72,width=7.5,height=4.5)
