# rather than having EVERY individual script check for and potentially
# redownload and disperse the data, we'll just have one script do it

     library(downloader)
     url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip';
     data_loc <- './data';
     data_file <- './data/download.zip'
     
     # this script assumes the user may want to forcibly redownload over existing data
     unlink(data_loc, recursive=TRUE, force=TRUE);
     dir.create(data_loc);
     download(url,mode="wb", dest=data_file);
     unzip(data_file, exdir=data_loc)
     unlink(data_file)

