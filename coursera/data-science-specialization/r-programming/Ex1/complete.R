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
    
    values <- vector(mode = "numeric", length = 0)
    ids <- vector(mode = "numeric", length = 0)
    
    for (i in id) {
        fileID <- paste("./", directory, "/", formatC(i, width=3, flag="0"), ".csv", sep="")
        data <- read.csv(fileID)
        values <- c(values,sum(complete.cases(data)))
        ids <- c(ids,i)
    }
    
    x <- data.frame(cbind(ids,values))
    colnames(x) <- c("id","nobs")
    x

}