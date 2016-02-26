source_data <- "./data/Source_Classification_Code.rds";
raw_data <- "./data/summarySCC_PM25.rds";
result_folder <- "./results";
result_file <- "./results/baltimore_emissions.png";

# make sure we won't be writing to nowhere
if (!file.exists(result_folder)) { 
     dir.create(result_folder);
}

# get and process the data from the files
#source <- readRDS(source_data);
pmdata <- readRDS(raw_data);
pmdata <- pmdata[pmdata$fips=="24510",]
by_the_year <- sapply(split(pmdata$Emissions, pmdata$year), mean)
rm(pmdata)

# plot it
png(filename=result_file, width=480, height=480, units="px")
barplot(by_the_year,ylab="Mean PM2.5")
title("Baltimore, MD PM2.5 Emissions by Year")
dev.off()
