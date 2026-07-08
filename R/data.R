# R/data.R

#' Sentinel-2 MGRS tile grid
#'
#' The Sentinel-2 (MGRS 100km) tiling grid, one row per tile with native UTM
#' extent and longitude/latitude extent, used by [stacit()] to resolve a
#' 5-character MGRS square designator (e.g. "55GEP") to a query extent.
#'
#' @format A data frame with 56686 rows and 15 columns:
#' \describe{
#'   \item{land}{logical, tile intersects land}
#'   \item{xmin,xmax,ymin,ymax}{numeric, tile extent in native UTM}
#'   \item{crs}{character, native UTM crs e.g. "EPSG:32701"}
#'   \item{zone}{character, UTM zone "01".."60"}
#'   \item{latband}{character, MGRS latitude band letter}
#'   \item{lonband}{character, MGRS 100km column/row pair}
#'   \item{antim_wrap}{logical, tile crosses the anti-meridian in longlat}
#'   \item{hemisphere}{character, "north" or "south"}
#'   \item{ll_xmin,ll_ymin,ll_xmax,ll_ymax}{numeric, tile extent in longlat}
#' }
#' @source Derived from the ESA Sentinel-2 tiling grid KML, see data-raw/sentinel-grid.R
"sentinel_grid"
