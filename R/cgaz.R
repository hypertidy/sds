
#' the geoBoundaries countries
#'
#' CGAZ() returns the DSN, a shapefile of geo boundaries, CGAZ_sql() returns SQL suitable for use
#' with GDAL, for the names or codes of countries.
#' @param old logical, return the old slow zipped shapefile or the new Parquet copy
#' @export
#' @name CGAZ
#' @aliases CGAZ_sql
CGAZ <- function(old = FALSE) {
  if (old) return("/vsizip//vsicurl/https://github.com/wmgeolab/geoBoundaries/raw/main/releaseData/CGAZ/geoBoundariesCGAZ_ADM0.zip")
 "/vsicurl/https://github.com/mdsumner/geoboundaries/releases/download/latest/geoBoundariesCGAZ_ADM0.parquet"
}

#' @param codes a list of iso3 country codes, or country names (this is a bit sketchy)
#'
#' @export
#' @importFrom countrycode countrycode
#' @name CGAZ
#' @examples
#' CGAZ_sql(c("Australia", "New Zealand"))
#' CGAZ_sql(c("AUS", "NZL"))
#' ## do something like gdal_raster_data(gebco(), target_res = 1,
#' ##                                        options = c("-crop_to_cutline",
#' ##                                        "-cutline", CGAZ(),
#' ##                                         "-csql", CGAZ_sql(c("Australia", "New Zealand")) ))
CGAZ_sql <- function(codes) {
  if (missing(codes)) {
    return("SELECT * FROM geoBoundariesCGAZ_ADM0")
  }
  dsn <- CGAZ()
  #where <- c("Australia", "New Zealand", "Antarctica")[1]
  layer <- "geoBoundariesCGAZ_ADM0" ##vapour::vapour_layer_names(dsn)[1L]

  if (any(!nchar(codes) == 3L)) {
    codes <- countrycode::countrycode(codes, "country.name", "iso3c")
  }

  csql <- sprintf("SELECT shapeGroup FROM %s WHERE shapeGroup IN (%s)", layer,  paste(paste0("'", codes, "'"), collapse = ","))

  #g <- vapour::vapour_read_geometry(dsn, sql = csql)
  #geb <- "/vsicurl/https://public.services.aad.gov.au/datasets/science/GEBCO_2021_GEOTIFF/GEBCO_2021.tif"
  #vapour::gdal_raster_data(geb, target_dim = c(100, 100), options = c("-cutline", dsn, "-csql", csql, "-crop_to_cutline"))
  csql
}
