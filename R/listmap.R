#' Title
#'
#' @param address
#'
#' @return string URI for List service
#' @export
#'
#' @examples
#' x <- list_address(c(2862, "LYELL",  "HAYES"))
#' #vals <- jsonlite::fromJSON(readr::read_file ( x), simplifyVector = F)$features[[1]]$attributes
#' #plot(v <- vect(list_parcel(vals$PID)))
#' #Sys.setenv("GDAL_DISABLE_READDIR_ON_OPEN"="TRUE")
#' #dem <- rast("/vsicurl/https://s3.us-west-2.amazonaws.com/us-west-2.opendata.source.coop/alexgleith/tasmania-dem-2m/Tasmania_Statewide_2m_DEM_14-08-2021.tif")
#' #plotRGB(project(rast(ortho), rast(v, res = .1), by_util = TRUE))
#' #plot(v, add = T)
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
  "/vsizip//vsicurl/listdata.thelist.tas.gov.au/opendata/data/LIST_PARCELS_HOBART.zip/list_parcels_hobart.shp"
}
