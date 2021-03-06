## Optimization of computation time: the "cache-technique".
## Its application on the computation of the inverse of a square matrix

## input: a square numerical invertible matrix "mat".
## Output: an extended version of mat. To avoid any misuse of that extended matrix,
## the extention cannot simply consist of a list (matrix,its inverse) but
## on the contrary the information must be embedded in functions that must be
## explicitely invoked. This is the motivation of the construction below:

makeCacheMatrix <- function(mat = matrix()) {
    invMat <- NULL
    set <- function(y) {
        mat <<- y
        invMat <<- NULL
    }
    get <- function() mat
    setInv <- function(z) invMat <<- z
    getInv <- function() invMat
    list(set = set, get = get,
         setInv = setInv,
         getInv = getInv)
}

## Input: An extended matrix of the form defined above.
## Output: a square numerical matrix (the expected inverse matrix).
## In addition, the CacheSolve function modifies the input object by storing in it
## the result of the calculation of the inverse matrix, in case this calculation
## wouldn't have been done before calling the cacheSolve function.
## Next time, this calculation will not need to be redone.

cacheSolve <- function(mat, ...) {
    ## Return a matrix that is the inverse of 'mat'
    invMat <- mat$getInv()
    if(!is.null(invMat)) {
        message("getting cached data")
        return(invMat)
    }
    data <- mat$get()
    invMat <- solve(data, ...)
    mat$setInv(invMat)
    invMat #That's the output: the last evaluation. Equivalent to "return(invMat)".
}

## A first test

mat <- matrix(1:4,2,2)
mat
matt <- makeCacheMatrix(mat)
invMat <- cacheSolve(matt)
invMat
mat %*% invMat

