#' Stacit query generator
#'
#' @param extent
#' @param date
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
stacit <- function(extent, date = "", collections = "sentinel-2-c1-l2a",
                     provider = c("https://earth-search.aws.element84.com/v1/search",
                                  "https://planetarycomputer.microsoft.com/api/stac/v1/search"),
                     asset = c("visual"),
                     gdal_stacit = FALSE,
                   limit = 1000) {

  provider <-  provider[1L]
  if (missing(extent)) stop("'extent' must be provided, a vector of 'c(xmin, xmax, ymin, ymax)' in longlat coords")

  if (extent[2] > 180) {
    bb <- c(paste0(c(extent[1], extent[3], 180, extent[4]), collapse = ","),
            paste0(c(-180, extent[3], extent[2] - 360, extent[4]), collapse = ","))
  } else {
    bb <- paste0(extent[c(1, 3, 2, 4)], collapse = ",")
  }


  date <- .datehandler(date)
  collections <- paste(collections, collapse = ",")
  asset <- paste(asset, collapse = ",")
  base <- sprintf("%s?collections=%s&bbox=%s&datetime=%s", provider, collections, bb, date)

  if (gdal_stacit) {
      return(sprintf("STACIT:\"%s\":asset=%s", base, asset))
  }

  sprintf("%s&limit=%i", base, limit)

}
