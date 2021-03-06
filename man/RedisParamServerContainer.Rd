% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/method-RedisContainer.R
\name{RedisParamServerContainer}
\alias{RedisParamServerContainer}
\title{Get the Redis server container}
\usage{
RedisParamServerContainer(environment = list(), tag = "latest")
}
\arguments{
\item{environment}{List, the environment variables in the container}

\item{tag}{Character, the image tag}
}
\value{
a \code{RedisContainer} object
}
\description{
Get the Redis server container.
}
\examples{
RedisServerContainer()
}
