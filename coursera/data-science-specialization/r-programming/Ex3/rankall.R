rankall <- function(outcome, num = "best") {
    ## Read outcome data and convert specific outcome columns to numeric
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data[, 11] <- as.numeric(data[, 11])
    data[, 17] <- as.numeric(data[, 17])
    data[, 23] <- as.numeric(data[, 23])

    ## Check that state and outcome are valid
    potentialOutcomes <- c("heart attack","heart failure","pneumonia")
    if (!is.element(outcome, potentialOutcomes)) { stop("invalid outcome") }

    if (outcome == "heart attack") { colIndex <- 11 }
    else if (outcome == "heart failure") { colIndex <- 17 }
    else if (outcome == "pneumonia") { colIndex <- 23 }
    
    ## Subset so only hospitals with mortality data are included
    data <- data[!is.na(data[,colIndex]),]

    ## For each state, find the hospital of the given rank
    unorderedStates <- unique(data[,7])
    states <- unorderedStates[order(unorderedStates)]
    
    ranks = NULL
    for (state in states) {
        hospital <- rankhospital(state, outcome, num, data)
        ranks <- rbind(ranks,data.frame(hospital, state))
    }
    
    ## Return a data frame with the hospital names and the abbreviated state name
    ranks
}
