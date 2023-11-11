#' Sentinel 2 WMS
#'
#' To use this you must have your own "INSTANCE_ID", set this in env var
#' "SENTINELHUB_INSTANCE_ID".
#' @param layer see layer options in the argument, default is "TRUE-COLOR-S2L2A"
#' @param datetime a valid datetime or NA for "latest"
#'
#' @return a string to a WMS
#' @export
#'
#' @examples
#' sentinel2_wms()
sentinel2_wms <- function(layer = c("TRUE-COLOR-S2L2A", "NDVI", "FALSE-COLOR", "FALSE-COLOR-URBAN", "AGRICULTURE",
"BATHYMETRIC", "GEOLOGY", "MOISTURE-INDEX", "SWIR", "NATURAL-COLOR"), datetime = NA) {
  layer <- match.arg(layer)
  INSTANCE_ID <- Sys.getenv("SENTINELHUB_INSTANCE_ID")

  template <- "WMS:https://services.sentinel-hub.com/ogc/wms/%s?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetTile&LAYERS=%s&SRS=EPSG:3857&BBOX=-20037508.342789,-20037508.342789,20037508.342789,20037508.342789"



  dsn <- sprintf(template, INSTANCE_ID, layer)


  if (!is.na(datetime)) {
    ## what if multiple, I forget ...
     datetime <- format(datetime, "%Y-%m-%dT%H:%M:%SZ")
     dsn <- paste0(dsn, "&", datetime)
  }
 dsn
}
