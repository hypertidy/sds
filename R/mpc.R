#' Microsoft Planetary Computer
#'
#' Function `mpc_stacit()` will return a full data source name for a Spatio-Temporal Asset Catalog ('STAC').
#'
#' Each argument has a default, use them to set the collection, datetime range, bounding box, and asset.
#'
#' If no asset is specfied the description is a complex source composed of multiple subdatasets ('GDAL' terminology).
#' In a 'STAC' context "asset" and "subdataset" are synonomous for 'GDAL'.
#' @param collection name of the collection e.g. "sentinel-2-l2a", "naip", or ""landsat-c2-l2"
#' @param bbox a string in the form 'xmin,ymin,xmax,ymax' where x,y are longitude and latitude values (OR a numeric extent xmin,xmax,ymin,ymax)
#' @param datetime a datetime of 1 or 2 values to give a range in time, if only one is given it is treated as an open interval to the present
#' @param asset name of the asset of interest, e.g. for "sentinel-2-l2a" there is "visual", "AOT", "B04" etc.
#' @param stacit logical, treat this as a 'GDAL STACIT' source, or just a generic MPC query, 'TRUE' by default
#'
#' @return a string, a data source name for 'GDAL'
#' @export
#'
#' @examples
#' mpc()
#'
#' ## we can be more general than GDAL, and say do a query to get Parquet for MS Buildings
#'
#' mpc(collection = "ms-buildings", stacit = FALSE, bbox = "140,-45,145,-30",
#'                                  datetime = as.Date("2000-01-01"))
#' ## read that url with jsonlite and investigate $features$assets$data$href
#' ## but it's all abfs:// azure special links
mpc <- function(collection = "sentinel-2-l2a", bbox = "146.5,-43.2,147.5,-42.2", datetime = Sys.Date() + c(-5, 1), asset = "", stacit = TRUE) {
  if (length(datetime) == 1L) {

    datetime <- paste0(format(datetime, "%Y-%m-%dT%H:%M:%SZ"), "%2F..")
  } else {
    datetime <- rep(datetime, length.out = 2L)
    datetime <- paste0(format(datetime, "%Y-%m-%dT%H:%M:%SZ"), collapse = "/")
  }
  if (is.numeric(bbox)) bbox <- paste0(bbox[c(1, 3, 2, 4)], collapse = ",")
  if (stacit) {
    dsn <- sprintf("STACIT:\"https://planetarycomputer.microsoft.com/api/stac/v1/search?collections=%s&bbox=%s&datetime=%s\"",
                   collection, bbox, datetime)
    if (nzchar(asset)) {
      dsn <- sprintf("%s:asset=%s", dsn, asset)
    }
  } else {
    dsn <- sprintf("https://planetarycomputer.microsoft.com/api/stac/v1/search?collections=%s&bbox=%s&datetime=%s",
                   collection, bbox, datetime)
    if (nzchar(asset)) {
      dsn <- sprintf("%s&asset=%s", dsn, asset)
    }
  }
  dsn
}



