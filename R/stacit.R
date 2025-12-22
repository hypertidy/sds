#' STAC Query URL Generator
#'
#' Generate STAC API search URLs from an extent and date specification. Provides
#' a simple interface for constructing valid STAC queries without manually
#' assembling URL parameters.
#'
#' @section Extent specification:
#' The extent can be specified as either:
#' \itemize{
#'   \item A numeric vector of length 4 giving xmin, xmax, ymin, ymax in longitude/latitude (EPSG:4326)
#'   \item A character string giving a 100km MGRS grid square code (e.g. "43DFD")
#' }
#'
#' Extents that cross the anti-meridian (i.e. where xmin < -180 or xmax > 180)
#' are automatically split into two queries, one for each side of the ±180° boundary.
#' This handles the case where a projected extent (e.g. UTM) spans the anti-meridian
#' but STAC APIs truncate bounding boxes at -180/180.
#'
#' @section Date specification:
#' The date parameter accepts flexible input formats that are expanded to
#' ISO 8601 datetime intervals:
#' \itemize{
#'   \item Year only: `"2024"` becomes `2024-01-01T00:00:00Z/2024-12-31T23:59:59Z`
#'   \item Year-month: `"2024-06"` expands to the full month interval
#'   \item Full date: `"2024-06-15"` expands to that single day
#'   \item Date range: `c("2024-01-01", "2024-01-31")` for explicit start/end
#'   \item Date or POSIXt objects are also accepted
#' }
#'
#' @param extent numeric vector (xmin, xmax, ymin, ymax) in longlat, or character
#'   MGRS 100km grid code
#' @param date character, Date, or POSIXt specifying the temporal query.
#'   Length 1 for an implied interval or length 2 for an explicit range.
#'   Default `""` uses today's date.
#' @param collections character; STAC collection identifier(s) to search.
#'   Default is `"sentinel-2-c1-l2a"` (Sentinel-2 Cloud-Optimized GeoTIFFs).
#' @param provider character; base URL of the STAC API search endpoint.
#'   Default uses Element 84's Earth Search. Also supports Microsoft Planetary Computer.
#' @param gdal_stacit logical; if `TRUE`, return a GDAL STACIT driver DSN string
#'   instead of a URL. Default `FALSE`.
#' @param limit integer; maximum number of items to return per query. Default 1000.
#'
#' @return Character vector of STAC search URL(s). Returns multiple URLs when
#'   the extent crosses the anti-meridian.
#'
#' @seealso [mpc()] for Microsoft Planetary Computer catalog access;
#'   [sentinel2_wms()] for Sentinel-2 WMS layer construction
#'
#' @references
#' STAC API specification: \url{https://github.com/radiantearth/stac-api-spec}
#'
#' GDAL STACIT driver: \url{https://gdal.org/en/stable/drivers/raster/stacit.html}
#'
#' @export
#'
#' @examples
#' # Simple bounding box query for today
#' stacit(c(140, 145, -43, -40))
#'
#' # MGRS grid square for a specific month
#' stacit("43DFD", date = "2025-01")
#'
#' # Date range query
#' stacit(c(140, 145, -43, -40), date = c("2024-06-01", "2024-06-30"))
#'
#' # Anti-meridian crossing returns two queries
#' stacit(c(179, 181, -16, -15), date = "2024-03")
#'
#' # Use Planetary Computer instead of Earth Search
#' stacit(c(140, 145, -43, -40),
#'        provider = "https://planetarycomputer.microsoft.com/api/stac/v1/search")
#'
#' # Query Landsat collection
#' stacit(c(140, 145, -43, -40), collections = "landsat-c2-l2", date = "2024")
stacit <- function(extent, date = "", collections = "sentinel-2-c1-l2a",
                   provider = c("https://earth-search.aws.element84.com/v1/search",
                                "https://planetarycomputer.microsoft.com/api/stac/v1/search"),
                   gdal_stacit = FALSE,
                   limit = 1000) {
  provider <-  provider[1L]
  if (missing(extent)) stop("'extent' must be provided, a vector of 'c(xmin, xmax, ymin, ymax)' in longlat coords, or a GZD tile identifier")


  if (is.character(extent)) {
    extent <- extent[1L]

    if (is.na(extent) || !(nchar(extent) == 5L)) stop("invalid character extent to stacit() use MGRS 100km square designator {GZD}{Column}{Row} i.e. '55GEP'")
  } else {
    extent <- extent[1:4]
    if(!(length(extent) == 4) || any(is.na(extent))) stop("invalid numeric extent to stacit() use longlat c(xmin,xmax,ymin,ymax)")
  }
  ## if bb is of length 2 it's because we have two regions either side of the antimeridian

  bb <- .extenthandler(extent)


  date <- .datehandler(date)
  collections <- paste(collections, collapse = ",")

  base <- sprintf("%s?collections=%s&%s&datetime=%s", provider, collections, bb, date)

  if (gdal_stacit) {
      return(sprintf("STACIT:\"%s\":asset=%s", base, asset))
  }

  URLencode(sprintf("%s&limit=%i", base, limit))

}
