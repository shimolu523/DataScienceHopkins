## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setInvert <- function(Invert) inv <<- Invert
    getInvert <- function() inv
    list(set = set, get = get,
         setInvert = setInvert,
         getInvert = getInvert)
    
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv <- x$getInvert()
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    data <- x$get()
    #print(data)
    inv <- solve(data, ...)
    x$setInvert(inv)
    inv
}
