best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data[, 11] <- as.numeric(data[, 11]); data[, 17] <- as.numeric(data[, 17]); data[, 23] <- as.numeric(data[, 23])

    ## Check that state and outcome are valid
    potentialOutcomes <- c("heart attack","heart failure","pneumonia")
    if (!is.element(outcome, potentialOutcomes)) { stop("invalid outcome") }
    if (!is.element(state, data[, 7])) { stop("invalid state") }

    ## Return hospital name in that state with lowest 30-day death rate
    ## Heart attack = col 11, heart failure = col 17, pneumonia = col 23
    ## Subset the data based on requested state

    dataSubset <- data[(data[,7] == state),]
    
    if (outcome == "heart attack") { colIndex <- 11 }
    else if (outcome == "heart failure") { colIndex <- 17 }
    else if (outcome == "pneumonia") { colIndex <- 23 }
    
    lowestRate <- min(dataSubset[,colIndex], na.rm = TRUE)
    hospitals <- dataSubset[(dataSubset[,colIndex] == lowestRate),2]
    cat(hospitals, "\n")
}
