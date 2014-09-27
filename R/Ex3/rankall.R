rankall <- function(outcome, num = "best") {
    ## Read outcome data and convert specific outcome columns to numeric
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data[, 11] <- as.numeric(data[, 11])
    data[, 17] <- as.numeric(data[, 17])
    data[, 23] <- as.numeric(data[, 23])

    ## Check that state and outcome are valid
    potentialOutcomes <- c("heart attack","heart failure","pneumonia")
    if (!is.element(outcome, potentialOutcomes)) { stop("invalid outcome") }

    ## For each state, find the hospital of the given rank

    ## Return a data frame with the hospital names and the abbreviated state name

}
