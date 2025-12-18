#' Stacit query generator
#'
#' STAC url query, as simple as extent and date(time).
#'
#' Extent can be an 100km grid square MGRS code, or a number extent for longlat.
#'
#' Date can be a single character "2025", "2025-01", "2025-01-01" or a pair of these for the
#' obvious range between dates or implied interval (day, month, year).
#' @param extent numeric longlat xmin,xmax,ymin,ymax OR character MGRS code (see details)
#' @param date character/Date/POSIXt length 1 or 2 (see details)
#' @param collections
#' @param provider
#' @param asset
#' @param gdal_stacit
#'
#' @return
#' @export
#'
#' @examples
#' stacit(c(140, 145, -43, -40))
#' stacit("43DFD", date = "2025-01")
stacit <- function(extent, date = "", collections = "sentinel-2-c1-l2a",
                     provider = c("https://earth-search.aws.element84.com/v1/search",
                                  "https://planetarycomputer.microsoft.com/api/stac/v1/search"),
                     asset = c("visual"),
                     gdal_stacit = FALSE,
                   limit = 1000) {

  provider <-  provider[1L]
  if (missing(extent)) stop("'extent' must be provided, a vector of 'c(xmin, xmax, ymin, ymax)' in longlat coords, or a GZD tile identifier")


  if (is.character(extent)) {
    extent <- extent[1L]

    if (is.na(extent) || !(nchar(extent) == 5L)) stop("invalid character extent to stacit() use MGRS 100km square designator {GZD}{Column}{Row} i.e. '55GEP'")
  } else {
    extent <- extent[1:4]
    if(!(length(extent) == 4) || any(is.na(extent))) stop("invalid numeric extent to stacit() use longlat xmin,xmax,ymin,ymax")
  }
  ## if bb is of length 2 it's because we have two regions either side of the antimeridian

  bb <- .extenthandler(extent)


  date <- .datehandler(date)
  collections <- paste(collections, collapse = ",")
  asset <- paste(asset, collapse = ",")
  base <- sprintf("%s?collections=%s&%s&datetime=%s", provider, collections, bb, date)

  if (gdal_stacit) {
      return(sprintf("STACIT:\"%s\":asset=%s", base, asset))
  }

  URLencode(sprintf("%s&limit=%i", base, limit))

}
