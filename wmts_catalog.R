# R/wmts_catalog.R
# Runtime functions for WMTS catalog - no spatial dependencies
# Just returns strings that GDAL can consume

#' WMTS Connection String Catalog
#'
#' Returns a GDAL-compatible WMTS connection string for common tile services.
#' These strings can be used directly with any GDAL-based tool, or chained with
#' the `vrt://` driver for overview control and other operations.
#'
#' @param name Character. Name of the tile service. Use `wmts_list()` to see
#'   available options. Partial matching is supported.
#' @param exact Logical. If TRUE, require exact name match. Default FALSE.
#'
#' @return Character string in WMTS: format suitable for GDAL.
#'
#' @details
#' The returned string follows the pattern:
#' `WMTS:<capabilities_url>,layer=<layer_name>[,tilematrixset=...,style=...]`
#'
#' This can be used with `vrt://` for additional control:
#' - `vrt://WMTS:...,layer=X?ovr=15` - limit to zoom level 15
#' - `vrt://WMTS:...,layer=X?a_srs=EPSG:3857` - force projection
#'
#' @examples
#' \dontrun{
#' # Get ESRI World Imagery
#' dsn <- wmts("esri_world_imagery
#')
#'
#' # Use with terra
#' library(terra)
#' r <- rast(dsn)
#'
#' # Limit zoom level for faster loading
#' dsn_fast <- paste0("vrt://", wmts("esri_world_imagery"), "?ovr=10")
#' r_fast <- rast(dsn_fast)
#'
#' # USGS topographic
#' topo <- wmts("usgs_topo")
#'
#' # Partial matching
#' wmts("imagery")  # matches first *imagery* entry
#' }
#'
#' @export
wmts <- function(name, exact = FALSE) {
  catalog <- wmts_catalog_data()

  if (exact) {
    if (!name %in% names(catalog)) {
      stop(sprintf("Unknown WMTS service: '%s'. Use wmts_list() to see options.", name))
    }
    return(catalog[[name]])
  }

  # Partial matching
  matches <- grep(name, names(catalog), ignore.case = TRUE, value = TRUE)
  if (length(matches) == 0) {
    stop(sprintf("No WMTS service matching '%s'. Use wmts_list() to see options.", name))
  }
  if (length(matches) > 1) {
    # Check for exact match first
    if (name %in% matches) {
      return(catalog[[name]])
    }
    message(sprintf("Multiple matches for '%s': %s\nReturning first match.",
                    name, paste(matches, collapse = ", ")))
  }
  catalog[[matches[1]]]
}


#' List Available WMTS Services
#'
#' @param pattern Optional character pattern to filter services.
#'
#' @return Character vector of service names.
#'
#' @examples
#' wmts_list()
#' wmts_list("esri")
#' wmts_list("imagery")
#'
#' @export
wmts_list <- function(pattern = NULL) {
  nms <- names(wmts_catalog_data())
  if (!is.null(pattern)) {
    nms <- grep(pattern, nms, ignore.case = TRUE, value = TRUE)
  }
  nms
}


#' WMTS Catalog Data
#'
#' Internal function returning the catalog as a named list.
#'
#' @return Named list of WMTS connection strings.
#' @keywords internal
wmts_catalog_data <- function() {
  list(
    # =========================================================================
    # ESRI ArcGIS Online Basemaps
    # =========================================================================

    esri_world_imagery = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Imagery/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Imagery",

    esri_world_street_map = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Street_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Street_Map",

    esri_world_topo = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Topo_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Topo_Map",

    esri_world_terrain = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Terrain_Base/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Terrain_Base",

    esri_world_shaded_relief = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Shaded_Relief/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Shaded_Relief",

    esri_world_physical = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Physical_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Physical_Map",

    esri_natgeo = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/NatGeo_World_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=NatGeo_World_Map",

    esri_ocean = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/Ocean_Basemap/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Ocean_Basemap",

    esri_dark_gray = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/Canvas/World_Dark_Gray_Base/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Dark_Gray_Base",

    esri_light_gray = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/Canvas/World_Light_Gray_Base/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Light_Gray_Base",

    esri_usa_topo = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/USA_Topo_Maps/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USA_Topo_Maps",

    # =========================================================================
    # USGS National Map (USA)
    # =========================================================================

    usgs_topo = "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSTopo/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSTopo",

    usgs_imagery = "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryOnly/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSImageryOnly",

    usgs_imagery_topo = "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryTopo/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSImageryTopo",

    usgs_shaded_relief = "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSShadedReliefOnly/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSShadedReliefOnly",

    usgs_hydro = "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSHydroCached/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSHydroCached",

    # =========================================================================
    # NASA GIBS - Global Imagery Browse Services
    # Note: Many layers are time-varying; these are common stable layers
    # Full catalog at: https://nasa-gibs.github.io/gibs-api-docs/
    # =========================================================================

    # Web Mercator (EPSG:3857)
    nasa_blue_marble = "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration",

    nasa_modis_terra_truecolor = "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/1.0.0/WMTSCapabilities.xml,layer=MODIS_Terra_CorrectedReflectance_TrueColor",

    nasa_viirs_snpp_truecolor = "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/1.0.0/WMTSCapabilities.xml,layer=VIIRS_SNPP_CorrectedReflectance_TrueColor",

    # Geographic (EPSG:4326)
    nasa_blue_marble_geo = "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg4326/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration",

    # Antarctic (EPSG:3031) - useful for your work!
    nasa_antarctic_blue_marble = "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3031/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration",

    nasa_antarctic_modis = "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3031/best/1.0.0/WMTSCapabilities.xml,layer=MODIS_Terra_CorrectedReflectance_TrueColor",

    # Arctic (EPSG:3413)
    nasa_arctic_blue_marble = "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3413/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration",

    # =========================================================================
    # Geoscience Australia
    # =========================================================================

    ga_topo = "WMTS:https://services.ga.gov.au/gis/rest/services/Topographic_Base_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Topographic_Base_Map",

    ga_national_map = "WMTS:https://services.ga.gov.au/gis/rest/services/NationalMap/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=NationalMap",

    ga_greyscale = "WMTS:http://services.ga.gov.au/gis/rest/services/NationalBaseMap_GreyScale/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=NationalBaseMap_GreyScale",

    # =========================================================================
    # Switzerland - Swisstopo (Free since March 2021)
    # =========================================================================

    # Web Mercator (EPSG:3857) - most compatible
    swisstopo_pixelkarte = "WMTS:https://wmts.geo.admin.ch/EPSG/3857/1.0.0/WMTSCapabilities.xml,layer=ch.swisstopo.pixelkarte-farbe",

    swisstopo_swissimage = "WMTS:https://wmts.geo.admin.ch/EPSG/3857/1.0.0/WMTSCapabilities.xml,layer=ch.swisstopo.swissimage",

    swisstopo_pixelkarte_grey = "WMTS:https://wmts.geo.admin.ch/EPSG/3857/1.0.0/WMTSCapabilities.xml,layer=ch.swisstopo.pixelkarte-grau",

    # Swiss LV95 (EPSG:2056) - native projection
    swisstopo_pixelkarte_lv95 = "WMTS:https://wmts.geo.admin.ch/EPSG/2056/1.0.0/WMTSCapabilities.xml,layer=ch.swisstopo.pixelkarte-farbe",

    # =========================================================================
    # Netherlands - PDOK
    # =========================================================================

    nl_achtergrondkaart = "WMTS:https://service.pdok.nl/brt/achtergrondkaart/wmts/v2_0?service=WMTS&request=GetCapabilities,layer=standaard",

    nl_achtergrondkaart_grijs = "WMTS:https://service.pdok.nl/brt/achtergrondkaart/wmts/v2_0?service=WMTS&request=GetCapabilities,layer=grijs",

    nl_luchtfoto = "WMTS:https://service.pdok.nl/hwh/luchtfotorgb/wmts/v1_0?service=WMTS&request=GetCapabilities,layer=Actueel_ortho25",

    # =========================================================================
    # Austria - basemap.at
    # =========================================================================

    austria_basemap = "WMTS:https://maps.wien.gv.at/basemap/1.0.0/WMTSCapabilities.xml,layer=geolandbasemap",

    austria_orthofoto = "WMTS:https://maps.wien.gv.at/basemap/1.0.0/WMTSCapabilities.xml,layer=bmaporthofoto30cm"
  )
}


#' Get WMTS Capabilities URL
#'
#' Extract just the GetCapabilities URL from a service name.
#' Useful for programmatic access or checking service status.
#'
#' @param name Character. Service name from `wmts_list()`.
#'
#' @return Character string with the GetCapabilities URL.
#'
#' @export
wmts_capabilities_url <- function(name) {
  dsn <- wmts(name, exact = TRUE)
  # Extract URL from "WMTS:url,layer=..."
  url <- gsub("^WMTS:", "", dsn)
  url <- strsplit(url, ",layer=")[[1]][1]
  url
}


#' Show WMTS Catalog Summary
#'
#' Print a formatted summary of available WMTS services.
#'
#' @export
wmts_info <- function() {
  catalog <- wmts_catalog_data()
  providers <- unique(gsub("_.*", "", names(catalog)))

  cat("WMTS Catalog for GDAL\n")
  cat("=====================\n\n")

  cat(sprintf("Total services: %d\n\n", length(catalog)))

  cat("Providers:\n")
  for (p in providers) {
    entries <- grep(sprintf("^%s_", p), names(catalog), value = TRUE)
    cat(sprintf("  %s (%d):\n", toupper(p), length(entries)))
    for (e in entries) {
      cat(sprintf("    - %s\n", e))
    }
    cat("\n")
  }

  cat("\nUsage:\n")
  cat("  dsn <- wmts('esri_world_imagery')\n")
  cat("  r <- terra::rast(dsn)\n")
  cat("\n")
  cat("  # With vrt:// for zoom control:\n")
  cat("  dsn <- paste0('vrt://', wmts('esri_world_imagery'), '?ovr=12')\n")

  invisible(catalog)
}
