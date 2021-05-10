###########################
## container provider
###########################
#' The BiocParallel RedisParam worker container
#'
#' The BiocParallel RedisParam worker container
#'
#' @exportClass RedisParamContainer
.RedisParamContainer <- setRefClass(
    "RedisParamContainer",
    contains = "RedisContainer"
)
