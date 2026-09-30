## Constant sources in this file are shims over the registry: the URL for each
## lives in inst/extdata/sds-registry.csv (see R/registry.R and dsn()). Edit
## the CSV to change a source; the functions only preserve the historical
## call signatures. Functions with real logic (mursst, ghrsst, the mapbox
## token templates) remain ordinary functions.

#' USGS seamless DEM
#'
#' @param vsicurl if TRUE prefix /vsicurl
#' @export
#' @examples
#'
#' usgs_seamless()
#'
usgs_seamless <- function(vsicurl = TRUE) {
  .shim("usgs_seamless", vsi = vsicurl)
}

#' Imagery online sources
#'
#' Raster and imagery online. Each function returns a GDAL-ready data source
#' name; for the `wms_*` family that is a 'GDAL_WMS' XML recipe, stored as a
#' file in the package (see `dsn_list(kind = "xml_file")`). The two mapbox
#' functions return a template with a `%s` slot for an access token and are
#' not registry rows.
#'
#' @name dsn-sources
#' @export
wms_arcgis_mapserver_ESRI.WorldImagery_tms <- function() dsn("esri_world_imagery_tms")

#' @name dsn-sources
#' @export
wms_arcgis_mapserver_tms <- function() dsn("esri_world_street_tms")

#' @name dsn-sources
#' @export
wms_googlehybrid_tms <- function() dsn("google_hybrid_tms")

#' @name dsn-sources
#' @export
wms_googleterrainstreets_tms <- function() dsn("google_terrain_streets_tms")

#' @name dsn-sources
#' @export
wms_virtualearth <- function() dsn("virtualearth_aerial")

#' @name dsn-sources
#' @export
wms_virtualearth_street <- function() dsn("virtualearth_street")

#' @name dsn-sources
#' @export
wms_openstreetmap_tms <- function() dsn("wms_openstreetmap_tms")

#' @name dsn-sources
#' @export
wms_amazon_elevation <- function() dsn("amazon_elevation_tms")

#' @name dsn-sources
#' @export
wms_ESA_worldcover_2020_tms <- function() dsn("esa_worldcover_2020")

#' @name dsn-sources
#' @export
wms_mapbox_satellite <- function()"<GDAL_WMS><Service name=\"TMS\"><ServerUrl>https://api.mapbox.com/v4/mapbox.satellite/${z}/${x}/${y}.jpg?access_token=%s</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>22</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:3857</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><!--<UserAgent>Please add a specific user agent text, to avoid the default one being used, and potentially blocked by OSM servers in case a too big usage of it would be seen</UserAgent>--><Cache /><ZeroBlockHttpCodes>204,404,401</ZeroBlockHttpCodes><ZeroBlockOnServerException>true</ZeroBlockOnServerException></GDAL_WMS>"

#' @name dsn-sources
#' @export
wms_mapbox_terrain <- function() "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>https://api.mapbox.com/v4/mapbox.terrain-rgb/${z}/${x}/${y}@2x.png?access_token=%s</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>15</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:3857</Projection><BlockSizeX>512</BlockSizeX><BlockSizeY>512</BlockSizeY><BandsCount>3</BandsCount><!--<UserAgent>Please add a specific user agent text, to avoid the default one being used, and potentially blocked by OSM servers in case a too big usage of it would be seen</UserAgent>--><Cache /></GDAL_WMS>"

#' @name dsn-sources
#' @export
nasadem <- function() dsn("nasadem")

#' @name dsn-sources
#' @export
cop90 <- function() dsn("cop90")
#' @name dsn-sources
#' @export
cop30 <- function() dsn("cop30")
#' @name dsn-sources
#' @export
srtm15 <- function() dsn("srtm15")

#' GEBCO source dsn
#'
#' A data source name to the GEBCO  elevation 'COG' GeoTIFF.
#'
#' GEBCO 2023 and 2022 is created and hosted by Philippe Massicotte.
#'
#' GEBCO 2019 and 2021 created and hosted by the Australian Antarctic Division,
#' served via the AADC data API (`data.aad.gov.au/eds/api`).
#'
#' See note about which forms of the bedrock vs ice surface are available. Generally we use the ice surface form, because that is what encountered while navigating the surface of the Earth. But, the bedrock is of course also of interest.
#' "If the data sets are used in a presentation or publication then we ask that you acknowledge the source. This should be of the form (see references)."
#' @references \url{https://www.gebco.net/data-products/gridded-bathymetry-data} 'GEBCO Compilation Group (2025) GEBCO 2025 Grid (doi:10.5285/37c52e96-24ea-67ce-e063-7086abc05f29)'
#'
#' GEBCO 2026, 2025 and 2024 are hosted on Source Cooperative by the Australian Antarctic Division.
#'
#' @section warning: please note that `gebco21()`, `gebco19()`, `gebco24()`, `gebco25()` and `gebco26()` return the *ice surface* form, while `gebco22()` returns the bedrock form. With `gebco23()` and `gebco23_bedrock()`,
#' thanks to Philippe Massicotte.
#'
#' @param vsi include the 'vsicurl' prefix (`TRUE` is default)
#'
#' @returns character string, URL to online GeoTIFF
#' @export
#'
#' @aliases gebco26 gebco25 gebco24 gebco22 gebco21 gebco19
#' @examples
#' gebco()
gebco <- function(vsi = TRUE) {
  gebco26(vsi = vsi)
}
#' @name gebco
#' @export
gebco26 <- function(vsi = TRUE) .shim("gebco26", vsi = vsi)
#' @name gebco
#' @export
gebco25 <- function(vsi = TRUE) .shim("gebco25", vsi = vsi)
#' @name gebco
#' @export
gebco24 <- function(vsi = TRUE) .shim("gebco24", vsi = vsi)
#' @name gebco
#' @export
gebco23_bedrock <- function(vsi = TRUE) .shim("gebco23_bedrock", vsi = vsi)
#' @name gebco
#' @export
gebco23 <- function(vsi = TRUE) .shim("gebco23", vsi = vsi)
#' @name gebco
#' @export
gebco22 <- function(vsi = TRUE) .shim("gebco22", vsi = vsi)
#' @name gebco
#' @export
gebco21 <- function(vsi = TRUE) .shim("gebco21", vsi = vsi)
#' @name gebco
#' @export
gebco19 <- function(vsi = TRUE) .shim("gebco19", vsi = vsi)

#' REMA elevation
#'
#' Reference Elevation Model of Antarctica, the 2m mosaic as a VRT with
#' rendered overviews (see github.com/mdsumner/rema-ovr).
#'
#' @return data source name for REMA v2
#' @export
#' @aliases rema_v2
#' @examples
#' rema()
rema <- function() {
  rema_v2()
}
#' @name rema
#' @export
rema_v2 <- function() dsn("rema_v2")

#' Tasmania DEM (2m)
#'
#' by MRT 2021
#'
#' @param vsicurl prefix with vsicurl or not
#'
#' @return data source name for Tasmania 2m DEM
#' @export
#'
#' @examples
#' tas_dem()
tas_dem <- function(vsicurl = TRUE) {
  .shim("tasmania_dem_2m", vsi = vsicurl)
}


#' MURSST (GHRSST) sst Zarr source
#'
#' This is used a lot of noisy fanfare about why everyone must move to Zarr in
#' the cloud. It's really big, daily netcdf blended/observation/model data on a
#' 36000x18000 grid, a regular grid in -180, 180, -90, 90.
#'
#' This zarr and every other one I've found is unuseably out of date.
#' It seems like this source doesn't go past "2020-01-21" or band 6443, don't know why that is.
#'
#' @name mursst
#' @param band a band number (defaults to 0, which is 2002-06-01)
#'
#' @return a string, a dsn for Zarr MURSST
#' @export
#'
#' @examples
#' mursst_zarr()
#' mursst_time("2019-10-08")
mursst_zarr <- function(band = 0) {
  sprintf("ZARR:\"/vsis3/mur-sst/zarr\":/analysed_sst:%i", band)
}

#' @param time a time value to pick, see Details
#'
#' @name mursst
#' @export
mursst_time <- function(time = NULL) {

  epoch <- as.Date("2002-06-01")
  if (!is.null(time)) {
    time <- as.Date(as.POSIXct(time))
  } else {
    time <- epoch
  }
  ## basically days since
  band <- as.Date(time) - epoch
  if (band < 0) stop("time is before the beginning")
  if (time > (Sys.Date()-5)) message("time is only 5 days ago or in the future")
  mursst_zarr(as.integer(band))
}

#' GHRSST files, GeoTIFFs on source.coop
#'
#' @return dataframe of source,date
#' @export
#'
#' @param vsi include the 'vsicurl' prefix (`TRUE` is default)
#'
#' @examples
#' files <- ghrsst()
#' tail(files$source)
ghrsst <- function(vsi = TRUE) {
 date <- as.POSIXct(seq(as.Date("2002-06-01"), Sys.Date() - 2, by = 1), tz = "UTC")
  template <- "https://data.source.coop/ausantarctic/ghrsst-mur-v2/%s/%s090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
  ymd <- format(date, '%Y/%m/%d')
  ymd2 <- format(date, '%Y%m%d')
  d <- tibble::tibble(source = sprintf(template, ymd, ymd2), date = date)
  if (vsi) d$source <- sprintf("/vsicurl/%s", d$source)
  d
}

#' IBCOS source dsn
#'
#' A data source name to the IBCSO  elevation 'COG' GeoTIFF.
#'
#' Currently at v2.
#'
#' @param vsi include the 'vsicurl' prefix (`TRUE` is default)
#' @param chart the image or the data? set to TRUE for image (it's a PDF)
#'
#' @returns character string, URL to online raster
#' @export
#'

#' @examples
#' ibcso()
#'
ibcso <- function(vsi = TRUE, chart = FALSE) {
  .shim(if (chart) "ibcso_chart" else "ibcso", vsi = vsi)
}

#' DEA 250m dem
#'
#' Australian Bathymetry and Topography 2023 250m MSL 'COG' (AusSeabed).
#'
#' The 2023 grid was superseded on 2024-12-05 by AusBathyTopo 250m 2024
#' (eCat 150050, doi:10.26186/150050) and the 2023 object removed, so this
#' function currently errors with that information (see the registry row).
#'
#' @param vsi include the 'vsicurl' prefix (`TRUE` is default)
#' @returns character string, URL to online raster
#' @export
dea_250m_dem <- function(vsi = TRUE) {
  .shim("dea_250m_dem", vsi = vsi)
}

#' #' GEDTDM global 1-arc second (30m) DEM
#' #'
#' #' Global Ensemble Digital Terrain Model 30m (GEDTM30)
#' #' https://zenodo.org/records/15490367
#' #' @export
#' #' @examples
#' #' gedtm30()
#' gedtm30 <- function() {
#'   "/vsicurl/https://s3.opengeohub.org/global/edtm/legendtm_rf_30m_m_s_20000101_20231231_go_epsg.4326_v20250130.tif"
#' }
