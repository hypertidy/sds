% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sources.R
\name{gedtm30}
\alias{gedtm30}
\title{GEDTM30 global 1-arc-second (~30m) Digital Terrain Model (DTM)}
\usage{
gedtm30(varname = "legendtm_rf_30m", vsi = TRUE)
}
\arguments{
\item{varname}{defaults to 'legendtm_rf_30m' (the elevation)}

\item{vsi}{include /vsicurl prefix}
}
\value{
for 'gedtm30_sources' dataframe of details about the files, for 'gedtm30' one of the variables source urls
}
\description{
GEDTM30 global 1-arc-second (~30m) Digital Terrain Model (DTM)
}
\examples{
gedtm30("hillshade_edtm")
}
