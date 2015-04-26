cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    print(data)
    m <- mean(data, ...)
    x$setmean(m)
    m
}