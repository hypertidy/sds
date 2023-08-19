#' Imagery online sources
#'
#' Raster and imagery online
#'
#' @name dsn-sources
#' @export
wms_arcgis_mapserver_ESRI.WorldImagery_tms <- function() "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/${z}/${y}/${x}</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>17</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><MaxConnections>10</MaxConnections><Cache /></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_bluemarble_s3_tms <- function() "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>http://s3.amazonaws.com/com.modestmaps.bluemarble/${z}-r${y}-c${x}.jpg</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>9</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><Cache/></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_googlehybrid_tms <- function()"<GDAL_WMS><!-- Data is subject to term of use detailed at http://code.google.com/intl/nl/apis/maps/terms.html andhttp://www.google.com/intl/en_ALL/help/terms_maps.html --><Service name=\"TMS\"><!-- ServerUrl>http://mt.google.com/vt/lyrs=m&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --><!-- Map --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=s&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Satellite --><ServerUrl>http://mt.google.com/vt/lyrs=y&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> <!-- Hybrid --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=t&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Terrain --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=p&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Terrain, Streets and Water  --></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>20</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><MaxConnections>5</MaxConnections><Cache /></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_virtualearth <- function()"<GDAL_WMS><Service name=\"VirtualEarth\"><ServerUrl>http://a${server_num}.ortho.tiles.virtualearth.net/tiles/a${quadkey}.jpeg?g=90</ServerUrl></Service><MaxConnections>4</MaxConnections><Cache/></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_ESA_worldcover_2020_tms <- function()"<GDAL_WMS><Service name=\"WMS\"><Version>1.1.1</Version><ServerUrl>https://services.terrascope.be/wms/v2?SERVICE=WMS</ServerUrl><Layers>WORLDCOVER_2020_MAP</Layers><SRS>EPSG:3857</SRS><ImageFormat>image/jpeg</ImageFormat><Transparent>FALSE</Transparent><BBoxOrder>xyXY</BBoxOrder></Service><DataWindow><UpperLeftX>-2.003750834E7</UpperLeftX><UpperLeftY>2.003750834E7</UpperLeftY><LowerRightX>2.003750834E7</LowerRightX><LowerRightY>-2.003750834E7</LowerRightY><SizeX>1073741824</SizeX><SizeY>1073741824</SizeY></DataWindow><BandsCount>3</BandsCount><BlockSizeX>1024</BlockSizeX><BlockSizeY>1024</BlockSizeY><OverviewCount>20</OverviewCount></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_mapbox_satellite <- function()"<GDAL_WMS><Service name=\"TMS\"><ServerUrl>https://api.mapbox.com/v4/mapbox.satellite/${z}/${x}/${y}.jpg?access_token=%s</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>22</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:3857</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><!--<UserAgent>Please add a specific user agent text, to avoid the default one being used, and potentially blocked by OSM servers in case a too big usage of it would be seen</UserAgent>--><Cache /><ZeroBlockHttpCodes>204,404,401</ZeroBlockHttpCodes><ZeroBlockOnServerException>true</ZeroBlockOnServerException></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_amazon_elevation <- function() "<GDAL_WMS>\n    <Service name=\"TMS\">\n        <ServerUrl>https://s3.amazonaws.com/elevation-tiles-prod/geotiff/${z}/${x}/${y}.tif</ServerUrl>\n    </Service>\n    <DataWindow>\n        <UpperLeftX>-20037508.340000</UpperLeftX>\n        <UpperLeftY>20037508.340000</UpperLeftY>\n        <LowerRightX>20037508.340000</LowerRightX>\n        <LowerRightY>-20037508.340000</LowerRightY>\n        <TileLevel>15</TileLevel>\n        <TileCountX>1</TileCountX>\n        <TileCountY>1</TileCountY>\n        <YOrigin>top</YOrigin>\n    </DataWindow>\n    <Projection>EPSG:3857</Projection>\n    <BlockSizeX>256</BlockSizeX>\n    <BlockSizeY>256</BlockSizeY>\n    <BandsCount>3</BandsCount>\n    <UserAgent>RStudio Server (2022.7.0.548); R (4.2.1 x86_64-pc-linux-gnu x86_64 linux-gnu)</UserAgent>\n</GDAL_WMS>"


#' @name dsn-sources
#' @export
wms_mapbox_terrain <- function() "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>https://api.mapbox.com/v4/mapbox.terrain-rgb/${z}/${x}/${y}@2x.png?access_token=%s</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>15</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:3857</Projection><BlockSizeX>512</BlockSizeX><BlockSizeY>512</BlockSizeY><BandsCount>3</BandsCount><!--<UserAgent>Please add a specific user agent text, to avoid the default one being used, and potentially blocked by OSM servers in case a too big usage of it would be seen</UserAgent>--><Cache /></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_openstreetmap_tms <- function() "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>https://tile.openstreetmap.org/${z}/${x}/${y}.png</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>18</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:3857</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><!--<UserAgent>Please add a specific user agent text, to avoid the default one being used, and potentially blocked by OSM servers in case a too big usage of it would be seen</UserAgent>--><Cache /></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_googleterrainstreets_tms <- function() "<GDAL_WMS><!-- Data is subject to term of use detailed at http://code.google.com/intl/nl/apis/maps/terms.html andhttp://www.google.com/intl/en_ALL/help/terms_maps.html --><Service name=\"TMS\"><!-- <ServerUrl>http://mt.google.com/vt/lyrs=m&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --><!-- Map --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=s&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Satellite --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=y&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Hybrid --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=t&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Terrain --><ServerUrl>http://mt.google.com/vt/lyrs=p&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> <!-- Terrain, Streets and Water  --></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>20</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><MaxConnections>5</MaxConnections><Cache /><ZeroBlockHttpCodes>204,404,401</ZeroBlockHttpCodes><ZeroBlockOnServerException>true</ZeroBlockOnServerException></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_virtualearth_street <- function() "<GDAL_WMS><Service name=\"VirtualEarth\"><ServerUrl>http://r${server_num}.ortho.tiles.virtualearth.net/tiles/r${quadkey}.jpeg?g=90</ServerUrl></Service><MaxConnections>4</MaxConnections><Cache/></GDAL_WMS>"
#' @name dsn-sources
#' @export
wms_arcgis_mapserver_tms <- function() "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>http://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/${z}/${y}/${x}</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>17</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><MaxConnections>10</MaxConnections><Cache /></GDAL_WMS>"

#' @name dsn-sources
#' @export
nasadem <- function() "/vsicurl/https://opentopography.s3.sdsc.edu/raster/NASADEM/NASADEM_be.vrt"

#' @name dsn-sources
#' @export
cop90 <- function() "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP90/COP90_hh.vrt"
#' @name dsn-sources
#' @export
cop30 <- function() "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP30/COP30_hh.vrt"
#' @name dsn-sources
#' @export
srtm15 <- function() "/vsicurl/https://opentopography.s3.sdsc.edu/raster/SRTM15Plus/SRTM15Plus_srtm.vrt"

#' GEBCO source dsn
#'
#' A data source name to the GEBCO  elevation 'COG' GeoTIFF.
#'
#' GEBCO 2022 is created and hosted by Philippe Massicotte.
#'
#' GEBCO 2019 and 2021 created and hosted by the Australian Antarctic Division.
#'
#' See note about which forms of the bedrock vs ice surface are available. Generally we use the ice surface form, because that is what encountered while navigating the surface of the Earth. But, the bedrock is of course also of interest.
#'
#'
#' @section warning: please note that `gebco21()`, `gebco19()` return the *ice surface* form, while `gebco22()` returns the bedrock form. With `gebco23()` and `gebco23_bedrock()` these are now both avaiable, again thanks to Philippe Massicotte.
#'
#' @param vsi include the 'vsicurl' prefix (`TRUE` is default)
#'
#' @returns character string, URL to online GeoTIFF
#' @export
#'
#' @aliases gebco22 gebco21 gebco19
#' @examples
#' gebco()
gebco <- function(vsi = TRUE) {
  gebco23(vsi = vsi)
}

#' @name gebco
#' @export
gebco21 <- function(vsi = TRUE) {
  url <- "https://public.services.aad.gov.au/datasets/science/GEBCO_2021_GEOTIFF/GEBCO_2021.tif"
  if (vsi) url <- file.path("/vsicurl", url)
  url
}

#' @name gebco
#' @export
gebco23_bedrock <- function(vsi = TRUE) {
  url  <- "https://gebco2023.s3.valeria.science/gebco_2023_sub_ice_topo_cog.tif"
  if (vsi) url <- file.path("/vsicurl", url)
  url
}

#' @name gebco
#' @export
gebco23 <- function(vsi = TRUE) {
  url <- "https://gebco2023.s3.valeria.science/gebco_2023_land_cog.tif"

  if (vsi) url <- file.path("/vsicurl", url)
  url
}

#' @name gebco
#' @export
gebco22 <- function (vsi = TRUE)
{
  url <- "https://gebco2022.s3.valeria.science/gebco_2022_complete_cog.tif"
  if (vsi)
    url <- file.path("/vsicurl", url)
  url
}

#' @name gebco
#' @export
gebco19 <- function(vsi = TRUE) {
  url <- "https://public.services.aad.gov.au/datasets/science/GEBCO_2019_GEOTIFF/GEBCO_2019.tif"
  if (vsi) url <- file.path("/vsicurl", url)
  url
}

#' the geoBoundaries countries
#'
#' @export
#' @name CGAZ
#' @aliases CGAZ_sql
CGAZ <- function() "/vsizip//vsicurl/https://github.com/wmgeolab/geoBoundaries/raw/main/releaseData/CGAZ/geoBoundariesCGAZ_ADM0.zip"

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
    #if (missing(codes)) stop("set codes to one or more iso3c country codes or their _names_, or to 'NULL' to get all")
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



#' MURSST (GHRSST) sst Zarr source
#'
#' This is used a lot of noisy fanfare about why everyone must move to Zarr in
#' the cloud. It's really big, daily netcdf blended/observation/model data on a
#' 36000x18000 grid, a regular grid in -180, 180, -90, 90.
#'
#'
#' It seems like this source doesn't go past "2020-01-21" or band 6443, don't know why that is.
#'
#'
#' @param band a band number (defaults to 0, which is 2002-06-01)
#'
#' @return a string, a dsn for Zarr MURSST
#' @export
#'
#' @examples
#' mursst()
#' mursst_time("2019-10-08")
mursst <- function(band = 0) {
  Sys.setenv("AWS_NO_SIGN_REQUEST"="yes")
  sprintf("ZARR:\"/vsis3/mur-sst/zarr\":/analysed_sst:%i", band)
}

#' @param time a time value to pick, see Details
#'
#' @name mursst
#' @export
mursst_time <- function(time = NULL) {
  Sys.setenv("AWS_NO_SIGN_REQUEST"="yes")
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
  mursst(band)
}


usgs_hydro <- function() {
  "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSHydroCached/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSHydroCached,tilematrixset=default028mm"
}
usgs_imagery <- function() {
  "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryOnly/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSImageryOnly,tilematrixset=default028mm"
}
usgs_image_topo <- function() {
  "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryTopo/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSImageryTopo,tilematrixset=default028mm"
}
usgs_shade <- function() {
  "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSShadedReliefOnly/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSShadedReliefOnly,tilematrixset=default028mm"
}
usgs_shade <- function() {
  "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSShadedReliefOnly/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSShadedReliefOnly,tilematrixset=default028mm"
}
usgs_tnmblank <- function() {
  "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSTNMBlank/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSTNMBlank,tilematrixset=default028mm"
}
usgs_topo <- function() {
  "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSTopo/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSTopo,tilematrixset=default028mm"
}

tasmap_sources <- function() {
  c(aerialphoto2020 = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/AerialPhoto2020/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_AerialPhoto2020,tilematrixset=default028mm",
    aerialphoto2021 = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/AerialPhoto2021/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_AerialPhoto2021,tilematrixset=default028mm",
    aerialphoto2022 = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/AerialPhoto2022/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_AerialPhoto2022,tilematrixset=default028mm",
    aerialphoto2023 = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/AerialPhoto2023/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_AerialPhoto2023,tilematrixset=default028mm",
    esgismapbookpublic = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/ESgisMapBookPUBLIC/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_ESgisMapBookPUBLIC,tilematrixset=default028mm",
    hillshadegrey = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/HillshadeGrey/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_HillshadeGrey,tilematrixset=default028mm",
    hillshade = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/Hillshade/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_Hillshade,tilematrixset=default028mm",
    orthophoto = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/Orthophoto/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_Orthophoto,tilematrixset=default028mm",
    simplebasemap = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/SimpleBasemap/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_SimpleBasemap,tilematrixset=default028mm",
    tasmap100k = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/Tasmap100K/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_Tasmap100K,tilematrixset=default028mm",
    tasmap250k = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/Tasmap250K/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_Tasmap250K,tilematrixset=default028mm",
    tasmap25k = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/Tasmap25K/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_Tasmap25K,tilematrixset=default028mm",
    tasmap500k = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/Tasmap500K/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_Tasmap500K,tilematrixset=default028mm",
    tasmapraster = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/TasmapRaster/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_TasmapRaster,tilematrixset=default028mm",
    topographicgrayscale = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/TopographicGrayScale/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_TopographicGrayScale,tilematrixset=default028mm",
    topographic = "WMTS:https://services.thelist.tas.gov.au/arcgis/rest/services/Basemaps/Topographic/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Basemaps_Topographic,tilematrixset=default028mm",
    street = "https://services.thelist.tas.gov.au/arcgis/rest/services/Raster/TTSA/MapServer/WMTS/1.0.0/WMTSCapabilities.xml"
  )
}



## see here for examples
## https://gist.github.com/mdsumner/c3f7dad2703b1ef73b95a4caa1daef55
ozgrab_bag_sources <- c("WMTS:https://maps.sa.gov.au/arcgis/rest/services/BaseMaps/StreetMap_wmas/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
                        "WMTS:https://spatial-gis.information.qld.gov.au/arcgis/rest/services/Basemaps/QldMap_Topo/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
                        "WMTS:https://mapprod1.environment.nsw.gov.au/arcgis/rest/services/LandCap/LandAndSoilCapability_EDP/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
                        "WMS:http://services.ga.gov.au/gis/services/Ausimage_Canberra_2014/ImageServer/WMSServer?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&LAYERS=Ausimage_Canberra_2014&SRS=EPSG:4326&BBOX=148.887753,-35.516701,149.293527,-35.122388",
                        "WMTS:https://services.ga.gov.au/gis/rest/services/Topographic_Base_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
                        "WMS:https://services.ga.gov.au/gis/services/Marine_Geomorphic_Features/MapServer/WmsServer?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&LAYERS=Geomorphic_Features&SRS=EPSG:4326&BBOX=93.412315,-60.923248,171.801102,-8.472063",
                        "WMTS:https://gissdi.dmp.wa.gov.au/gisexternal/rest/services/External/GSD_Basemap_External/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
                        "WMTS:https://base.maps.vic.gov.au/service?service=wmts&request=getCapabilities,layer=CARTO_WM_256"
)
