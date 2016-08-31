corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    correlations <- vector(mode = "numeric", length = 0)
    
    for (i in 1:332) {
        num_complete <- complete("specdata", i)
        if (num_complete$nobs > threshold) {
            fileID <- paste("./", directory, "/", formatC(i, width=3, flag="0"), ".csv", sep="")
            data <- read.csv(fileID)
            current_corr <- cor(data$sulfate,data$nitrate,use="complete.obs")
            correlations <- c(correlations,current_corr)
        }
    }
    correlations
}