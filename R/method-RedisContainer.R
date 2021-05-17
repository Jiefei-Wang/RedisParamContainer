RedisParamContainer <- function(image = "", name = NULL,  environment = list(),
                                maxWorkerNum = 4L,
                                RPackages = NULL,
                                sysPackages = NULL){
  .RedisParamContainer$new(
    name=name, image = image,
    environment = environment,
    maxWorkerNum = as.integer(maxWorkerNum),
    RPackages=RPackages,
    sysPackages=sysPackages,
    backend = "RedisParam")
}


#' Get the Redis server container
#'
#' Get the Redis server container.
#'
#' @inheritParams RedisBaseContainer::RedisServerContainer
#' @examples RedisServerContainer()
#' @return a `RedisContainer` object
#' @export
RedisParamServerContainer <- function(environment = list(), tag = "latest"){
  RedisBaseContainer::RedisServerContainer(environment = environment, tag = tag)
}

#' Get the RedisParam worker container
#'
#' Get the RedisParam worker container.
#'
#' @param image Character, the worker image used by the container
#' @param RPackages Character, a vector of R packages that will be installed
#' by `AnVIL::install` before connecting with the server
#' @param sysPackages Character, a vector of system packages that will be installed
#' by `apt-get install` before running the R worker
#' @param environment List, the environment variables in the container
#' @param maxWorkerNum Integer, the maximum worker number in a container
#' @param tag Character, the image tag
#'
#' @examples
#' RedisParamWorkerContainer(image = "r-base")
#' @return a `RedisParamContainer` object
#' @export
RedisParamWorkerContainer <- function(
  image = c("r-base", "bioconductor"),
  RPackages = NULL,
  sysPackages = NULL,
  environment = list(),
  maxWorkerNum = 4L,
  tag = "latest"){
  image <- match.arg(image)

  name <- "redisRWorkerContainer"
  image <- paste0("dockerparallel/", image, "-worker:",tag)
  RedisParamContainer(image = image, name=name, RPackages=RPackages, sysPackages=sysPackages,
                      environment=environment,
                      maxWorkerNum=maxWorkerNum)
}
