% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sources.R
\name{rema}
\alias{rema}
\alias{rema_v2}
\title{REMA reference elevation model of Antarctica}
\usage{
rema()

rema_v2()
}
\value{
character string, GDAL-readable raster data source name
}
\description{
This is a single description string for all of the 2m REMA. The VRT is crafted with efficient
overviews so is much more performant with the warper API than other existing descriptions.
}
\details{
See \href{https://github.com/mdsumner/rema-ovr}{rema-ovr} for examples.
}
