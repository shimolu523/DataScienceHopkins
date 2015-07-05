best <- function(state, outcome) {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    
    # loading data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # select category for rating
    stateNames <- unique(data$State)
    
    # print(category)
    # rate in a particular state
    if (state %in% stateNames){
        subData <- data[data$State == state,]
        #print(subData)
        if (outcome == "heart attack"){
            subData_cat <- subData$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
        }
        else if (outcome == "heart failure"){
            subData_cat <- subData$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
        }
        else if (outcome == "pneumonia"){
            subData_cat <- subData$"Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"      
        }
        else{
            stop("invalid outcome")
        }
        subData_cat <- as.numeric(subData_cat)
        index <- which.min(subData_cat)
        #print(index)
        print(subData_cat[index])
        hosName <- subData[index,2]
    }
    else{
        stop("invalid state")
    }
    hosName
}