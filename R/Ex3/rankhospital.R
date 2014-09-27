rankhospital <- function(state, outcome, num = "best", contents = NULL) {
    ## Read outcome data and convert specific outcome columns to numeric
    if (is.null(contents)) {
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        data[, 11] <- as.numeric(data[, 11])
        data[, 17] <- as.numeric(data[, 17])
        data[, 23] <- as.numeric(data[, 23])
    } else {
        data <- contents
    }
    
    ## Check that state and outcome are valid
    potentialOutcomes <- c("heart attack","heart failure","pneumonia")
    if (!is.element(outcome, potentialOutcomes)) { stop("invalid outcome") }
    if (!is.element(state, data[, 7])) { stop("invalid state") }
    
    ## Subset the data based on requested state
    dataSubset <- data[(data[,7] == state),]

    if (outcome == "heart attack") { colIndex <- 11 }
    else if (outcome == "heart failure") { colIndex <- 17 }
    else if (outcome == "pneumonia") { colIndex <- 23 }
    
    ## Subset so only hospitals with mortality data are included
    dataSubset <- dataSubset[!is.na(dataSubset[,colIndex]),]

    ## Order hospitals by mortality rate then alphabetically
    dataSubset <- dataSubset[order(dataSubset[,colIndex],dataSubset[,2]),]
    
    numHospitals <- length(dataSubset[,2])
    
    ## Determine the hospital that corresponds to the requested rank
    if (num == "best") { hospital <- dataSubset[1,2] }
    else if (num == "worst") { hospital <- dataSubset[numHospitals,2] }
    else if (num > numHospitals) { hospital <- NA }
    else { hospital <- dataSubset[num,2] }

    hospital
}
