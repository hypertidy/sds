#' Tasmania theLIST address query
#'
#' Build a query URI for the Tasmanian theLIST address service.
#'
#' @param address character vector of length 3: street number, street name,
#'   and locality
#'
#' @return string URI for List service
#' @export
#'
#' @examples
#' list_address(c(2862, "LYELL", "HAYES"))
list_address <- function(address) {
  ## if any spaces in address replace with "+"
  address <- gsub(" ", "+", address)
base <- "https://services.thelist.tas.gov.au/arcgis/rest/services/Public/OpenDataWFS/MapServer/9/query?"
 #where <- sprintf("where=(ST_NO_FROM=22%20AND%20STREET='REIDS')&outFields=EASTING,NORTHING,PID&returnGeometry=false&returnTrueCurves=false&f=pjson"
where <- sprintf("where=(ST_NO_FROM=%i AND STREET='%s'  AND LOCALITY='%s')&outFields=EASTING,NORTHING,PID&returnGeometry=false&returnTrueCurves=false&f=pjson",
                 as.integer(address[1]), toupper(address[2]), toupper(address[3]))

gsub(" ", "%20", paste0(base, where))
}


list_parcel <- function(PID) {
  sprintf("ESRIJSON:%s?where=(PID=%i)&f=pjson&outFields=OBJECTID",
          "https://services.thelist.tas.gov.au/arcgis/rest/services/Public/OpenDataWFS/MapServer/14/query",
          PID)
}
#' Cadastral parcel source
#'
#' @return string URI for List shapefile
#' @export
#'
#' @examples
#' list_parcel_shp()  ## read with terra::vect( ) or new(gdalraster::GDALVector, )
list_parcel_shp <- function() {
  dsn("list_parcel_shp")
}
