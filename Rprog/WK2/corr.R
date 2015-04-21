corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    files_list <- list.files(directory, full.names=TRUE)
    nFiles <- length(files_list)
    dat_corr <- c()
    for (i in 1:nFiles) {                                
        dat_i <- read.csv(files_list[i])
        sub_dat_i <- dat_i[,2:3]
        comp_data_i <- sub_dat_i[complete.cases(sub_dat_i),]
        nobs_i <- nrow(comp_data_i)
        if (nobs_i > threshold) {
            comp_sul_i <- comp_data_i[,1]
            comp_nit_i <- comp_data_i[,2]
            dat_corr_i <- cor(comp_sul_i,comp_nit_i)
            dat_corr <- c(dat_corr,dat_corr_i)
            
        }
    }
    dat_corr
}