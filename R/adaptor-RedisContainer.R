#' Configure the RedisParam worker container
#'
#' Configure the RedisParam worker container
#'
#' @inheritParams DockerParallel::configWorkerContainerEnv
#' @return A `RedisParamContainer` object
#' @export
setMethod("configWorkerContainerEnv", "RedisParamContainer",
          function(container, cluster, workerNumber, verbose = FALSE){
              container <- callNextMethod()
              container$environment$backend <-
                  "RedisParam"
              container
          }
)


#' Register the BiocParallel RedisParam backend
#'
#' Register the BiocParallel RedisParam backend. The registration will be done via
#' `RedisParam::RedisParam`
#'
#' @inheritParams DockerParallel::registerParallelBackend
#' @param ... The additional parameter that will be passed to `RedisParam::RedisParam`
#' @return No return value
#' @export
setMethod("registerParallelBackend", "RedisParamContainer",
          function(container, cluster, verbose = FALSE, ...){
              queue <- .getJobQueueName(cluster)
              password <- .getServerPassword(cluster)
              serverPort <- .getServerPort(cluster)
              if(.getServerClientSameLAN(cluster)){
                  serverClientIP <- .getServerPrivateIp(cluster)
              }else{
                  serverClientIP <- .getServerPublicIp(cluster)
              }

              if(is.null(serverClientIP)){
                  stop("Fail to find the server Ip")
              }
              stopifnot(!is.null(serverPort))
              p <- RedisParam::RedisParam(jobname = queue,
                                          manager.hostname = serverClientIP,
                                          manager.port = serverPort,
                                          manager.password = password, is.worker = FALSE, ...)
              BiocParallel::register(p)
              invisible(NULL)
          })

#' Deregister the BiocParallel RedisParam backend
#'
#' Deregister the BiocParallel RedisParam backend. The `BiocParallel::SerialParam()` will
#' be registered
#'
#' @inheritParams DockerParallel::deregisterParallelBackend
#' @param ... Not used
#' @return No return value
#' @export
setMethod("deregisterParallelBackend", "RedisParamContainer",
          function(container, cluster, verbose = FALSE, ...){
              BiocParallel::register(BiocParallel::SerialParam())
              invisible(NULL)
          })
