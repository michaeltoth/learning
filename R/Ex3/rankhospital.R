rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data and convert specific outcome columns to numeric
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data[, 11] <- as.numeric(data[, 11])
    data[, 17] <- as.numeric(data[, 17])
    data[, 23] <- as.numeric(data[, 23])

    ## Check that state and outcome are valid
    potentialOutcomes <- c("heart attack","heart failure","pneumonia")
    if (!is.element(outcome, potentialOutcomes)) { stop("invalid outcome") }
    if (!is.element(state, data[, 7])) { stop("invalid state") }
    # If num is larger than number of hospitals in state, return NA or fail
    
    ## Subset the data based on requested state
    dataSubset <- data[(data[,7] == state),]

    if (outcome == "heart attack") { colIndex <- 11 }
    else if (outcome == "heart failure") { colIndex <- 17 }
    else if (outcome == "pneumonia") { colIndex <- 23 }

    # Order hospitals by mortality rate then alphabetically

    # Detemine the lowest mortality rate for the given disease
    lowestRate <- min(dataSubset[,colIndex], na.rm = TRUE)

    ## Return hospital name in that state with lowest 30-day death rate.
    hospitals <- dataSubset[(dataSubset[,colIndex] == lowestRate),2]
    
    # Remove NA and sort list alphabetically to return only the first hospital
    hospitals <- hospitals[!is.na(hospitals)]
    hospitals <- hospitals[order(hospitals)]
    hospitals
}
}
