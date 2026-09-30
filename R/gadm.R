#' GADM administrative boundaries
#'
#' GADM 4.1 whole-planet administrative areas as GeoParquet, hosted as an
#' sds release asset. The original single GeoPackage from geodata.ucdavis.edu
#' is available as `dsn("gadm_gpkg")`. GADM data is free for academic and
#' non-commercial use only, see gadm.org/license.
#'
#' @param vsi include the 'vsicurl' prefix (`TRUE` is default)
#' @return data source name for GADM 4.1 GeoParquet
#' @export
#' @examples
#' gadm()
gadm <- function(vsi = TRUE) {
  .shim("gadm", vsi = vsi)
}
