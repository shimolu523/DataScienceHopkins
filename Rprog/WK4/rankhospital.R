rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    # loading data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # select category for rating
    stateNames <- unique(data$State)
    
    # print(category)
    # rate in a particular state
    if (state %in% stateNames){
        subData <- data[data$State == state,]
        #subData <- as.numeric(subData)
        #print(subData)
        if (outcome == "heart attack"){
            subData$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" <- as.numeric(subData$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")
            subData_sort <- subData[order(subData$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", subData$"Hospital.Name"),]
            subData_sort <- subData_sort[complete.cases(subData_sort$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"),]
        }
        else if (outcome == "heart failure"){
            subData$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure" <- as.numeric(subData$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")
            subData_sort <- subData[order(subData$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", subData$"Hospital.Name"),]
            subData_sort <- subData_sort[complete.cases(subData_sort$"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"),]
        }
        else if (outcome == "pneumonia"){
            subData$"Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" <- as.numeric(subData$"Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")    
            subData_sort <- subData[order(subData$"Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia", subData$"Hospital.Name"),]      
            subData_sort <- subData_sort[complete.cases(subData_sort$"Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"),]
        }
        else{
            stop("invalid outcome")
        }
        N_lim <- nrow(subData_sort)
        if (num == "best"){
            index <- 1
        }
        else if (num == "worst"){
            index <- N_lim
        }
        else if (num < 1 | num> N_lim){
            return(NA)
        }
        else{
            index <- num
        }
        #print(index)
        hosName <- subData_sort[index,2]
    }
    else{
        stop("invalid state")
    }
    hosName   
}