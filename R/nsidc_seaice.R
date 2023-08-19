
#' Data sources for NOAA NSIDC GeoTIFF images for sea ice concentration and extent.
#'
#' Data is colour-palette GeoTIFF in polar stereographic raster format.
#'
#' The availability of the date is not checked currently, the minimum date is 1978-10-26. Please note that these
#' data were only every two days from date, until a later time (FIXME get these details).
#'
#' @param date date in POSIXct or Date format, see Details
#' @param hemisphere hemisphere of data source, north or south
#' @param temporal temporal resolution of data source, daily or monthly
#' @param varname variable name to obtain, concentration or extent (note this is a colour image)
#' @param vsi prepend DSN with "/vsicurl/" or not
#'
#' @return character string, GDAL readable DSN to a colour palette GeoTIFF (see args 'vsi' and others for options)
#' @export
#'
#' @examples
#' nsidc_seaice("2023-06-27")
#' #readBin(con <- url(nsidc_seaice("2023-06-27", vsi = FALSE), open = "rb"), "raw"); close(con)
nsidc_seaice <- function(date, hemisphere = c("south", "north"),
                         temporal = c("daily", "monthly"),
                         varname = c("concentration", "extent"), vsi = TRUE) {
  HEMI <- match.arg(hemisphere)
  TEMPORAL <- match.arg(temporal)
  if (missing(date)) {
    date <- Sys.Date() - 7
  }
  date <- as.POSIXct(date, tz = "UTC")
  YEAR <- format(date, "%Y")
  MON_MON <- format(date, "%m_%b")
  noaabase <- sprintf("https://noaadata.apps.nsidc.org/NOAA/G02135/%s/%s/geotiff/%s/%s",
                      HEMI, TEMPORAL, YEAR, MON_MON)


  VARNAME <- match.arg(varname)
  noaafile <- sprintf("%s_%s_%s_v3.0.tif",
                      toupper(substr(HEMI, 1, 1)),
                      format(date, "%Y%m%d"),
                      VARNAME)

  mindate <- as.POSIXct("1978-10-26", tz = "UTC")

  urlbase <- sprintf("%s/%s", noaabase, noaafile)

  ## check it?
  #con <- url(url, open = "rb")
  #readBin(con, "raw")
  #close(con)

  if (vsi) {
    sprintf("/vsicurl/%s", urlbase)
  } else {
    urlbase
  }
}
