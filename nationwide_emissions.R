source_data <- "./data/Source_Classification_Code.rds";
raw_data <- "./data/summarySCC_PM25.rds";
result_folder <- "./results";
result_file <- "./results/nationwide_emissions.png";

# make sure we won't be writing to nowhere
if (!file.exists(result_folder)) { 
     dir.create(result_folder);
}

# mean just the Emissions column and not ALL columns as apply alone likes to do
mean_the_split <- function(pm25) {
     spl <- split(pm25, pm25$year)
     sapply(spl, function(x) mean(x$Emissions) )
}

# get and process the data from the files
#source <- readRDS(source_data);
pmdata <- readRDS(raw_data);
by_the_year <- mean_the_split(pmdata)
rm(pmdata)

# plot it
png(filename=result_file, width=480, height=480, units="px")
barplot(by_the_year,ylab="Mean PM2.5")
title("Nationwide PM2.5 Emissions by Year")
dev.off()
