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
