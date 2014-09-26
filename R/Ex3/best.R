best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

    ## Check that state and outcome are valid
    potentialOutcomes <- c("heart attack","heart failure","pneumonia")
    if (!is.element(outcome, potentialOutcomes)) { stop("invalid outcome") }
    if (!is.element(state, data[, 7])) { stop("invalid state") }

    ## Return hospital name in that state with lowest 30-day death rate
    ## Heart attack = col 11, heart failure = col 17, pneumonia = col 23

}
