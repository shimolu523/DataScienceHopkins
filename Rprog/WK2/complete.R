complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    files_list <- list.files(directory, full.names=TRUE)
    dat <- data.frame() 
    for (i in id) {                                
        #loops through the files, rbinding them together
        dat_i <- read.csv(files_list[i])
        #sul_dat_i <- dat_i[,2]
        #nit_dat_i <- dat_i[,3]
        #nob_sul <- length(sul_dat_i[complete.cases(sul_dat_i)])
        #nob_nit <- length(nit_dat_i[complete.cases(nit_dat_i)])
        #nob_i <- nob_sul + nob_nit
        sub_dat_i <- dat_i[,2:3]
        #print(sub_dat_i)
        comp_data_i <- sub_dat_i[complete.cases(sub_dat_i),]
        #print(comp_data_i)
        nob_i <- nrow(comp_data_i)
        #print(nob_i)
        dat <- rbind(dat, c(i,nob_i))
        dat_name <- c('id','nobs')
        names(dat) <- dat_name
    }
    dat
}