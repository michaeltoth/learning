## These functions make use of lexical scoping to store the inverse of a matrix
## in cache and retrieve it using the defined functions within makeCacheMatrix 
## which is faster than recomputing each time it is needed

## Creates a special matrix with functions to set the value of the matrix, get
## the value of the matrix, set the inverse, and retrieve the inverse

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) m <<- inverse
    getinverse <- function() m
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## Returns the inverse of the matrix, first checking if a cached inverse is
## available and if not computing the inverse using the solve function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getinverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
}
