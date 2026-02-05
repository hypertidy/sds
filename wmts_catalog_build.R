# data-raw/build_wmts_catalog.R
# Build-time script to generate WMTS connection strings for sds
# No spatial dependencies required at runtime - just stores strings

library(xml2)
library(httr2)

# Helper to parse WMTS GetCapabilities and extract layer info
parse_wmts_capabilities <- function(url, timeout = 30) {
  tryCatch({
    resp <- request(url) |>
      req_timeout(timeout) |>
      req_perform()

    xml <- read_xml(resp_body_string(resp))

    # Handle various namespace configurations
    ns <- xml_ns(xml)
    # Try to find the WMTS namespace
    wmts_prefix <- names(ns)[grepl("wmts|OGC", ns, ignore.case = TRUE)][1]
    ows_prefix <- names(ns)[grepl("ows", ns, ignore.case = TRUE)][1]

    if (is.na(wmts_prefix)) wmts_prefix <- "d1"
    if (is.na(ows_prefix)) ows_prefix <- "ows"

    # Try multiple XPath patterns for layers
    layers <- xml_find_all(xml, ".//Layer", ns = xml_ns(xml))
    if (length(layers) == 0) {
      layers <- xml_find_all(xml, sprintf(".//%s:Layer", wmts_prefix), ns)
    }
    if (length(layers) == 0) {
      layers <- xml_find_all(xml, "//Layer")
    }

    lapply(layers, function(layer) {
      # Try to get Identifier
      id <- xml_text(xml_find_first(layer, ".//Identifier") %||%
                       xml_find_first(layer, sprintf(".//%s:Identifier", ows_prefix), ns) %||%
                       xml_find_first(layer, ".//ows:Identifier", ns))

      # Try to get TileMatrixSet
      tms <- xml_text(xml_find_first(layer, ".//TileMatrixSet") %||%
                        xml_find_first(layer, ".//TileMatrixSetLink/TileMatrixSet") %||%
                        xml_find_first(layer, sprintf(".//%s:TileMatrixSet", wmts_prefix), ns))

      # Try to get Style
      style <- xml_text(xml_find_first(layer, ".//Style/Identifier") %||%
                          xml_find_first(layer, sprintf(".//%s:Style/%s:Identifier", wmts_prefix, ows_prefix), ns))
      if (is.na(style) || style == "") style <- "default"

      list(
        layer = id,
        tilematrixset = tms,
        style = style
      )
    })
  }, error = function(e) {
    message(sprintf("Failed to parse %s: %s", url, e$message))
    list()
  })
}

# Build a GDAL-compatible WMTS connection string
build_wmts_gdal_string <- function(capabilities_url, layer, tilematrixset = NULL, style = NULL) {
  parts <- c(
    sprintf("WMTS:%s", capabilities_url),
    sprintf("layer=%s", layer)
  )
  if (!is.null(tilematrixset) && !is.na(tilematrixset) && tilematrixset != "") {
    parts <- c(parts, sprintf("tilematrixset=%s", tilematrixset))
  }
  if (!is.null(style) && !is.na(style) && style != "" && style != "default") {
    parts <- c(parts, sprintf("style=%s", style))
  }
  paste(parts, collapse = ",")
}

# ============================================================================
# WMTS ENDPOINTS CATALOG
# ============================================================================
# These are verified, publicly accessible WMTS endpoints organized by provider

wmts_endpoints <- list(

  # -------------------------------------------------------------------------
  # ESRI ArcGIS Online - World Basemaps
  # -------------------------------------------------------------------------
  esri = list(
    world_imagery = "https://services.arcgisonline.com/arcgis/rest/services/World_Imagery/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    world_street_map = "https://services.arcgisonline.com/arcgis/rest/services/World_Street_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    world_topo_map = "https://services.arcgisonline.com/arcgis/rest/services/World_Topo_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    world_terrain_base = "https://services.arcgisonline.com/arcgis/rest/services/World_Terrain_Base/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    world_shaded_relief = "https://services.arcgisonline.com/arcgis/rest/services/World_Shaded_Relief/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    world_physical_map = "https://services.arcgisonline.com/arcgis/rest/services/World_Physical_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    natgeo_world_map = "https://services.arcgisonline.com/arcgis/rest/services/NatGeo_World_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    usa_topo_maps = "https://services.arcgisonline.com/arcgis/rest/services/USA_Topo_Maps/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    canvas_world_dark_gray = "https://services.arcgisonline.com/arcgis/rest/services/Canvas/World_Dark_Gray_Base/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    canvas_world_light_gray = "https://services.arcgisonline.com/arcgis/rest/services/Canvas/World_Light_Gray_Base/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    ocean_basemap = "https://services.arcgisonline.com/arcgis/rest/services/Ocean_Basemap/MapServer/WMTS/1.0.0/WMTSCapabilities.xml"
  ),

  # -------------------------------------------------------------------------
  # USGS National Map
  # -------------------------------------------------------------------------
  usgs = list(
    topo = "https://basemap.nationalmap.gov/arcgis/rest/services/USGSTopo/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    imagery = "https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryOnly/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    imagery_topo = "https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryTopo/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    shaded_relief = "https://basemap.nationalmap.gov/arcgis/rest/services/USGSShadedReliefOnly/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    hydro_nhd = "https://basemap.nationalmap.gov/arcgis/rest/services/USGSHydroCached/MapServer/WMTS/1.0.0/WMTSCapabilities.xml"
  ),

  # -------------------------------------------------------------------------
  # NASA GIBS - Global Imagery Browse Services
  # Note: GIBS uses time-varying layers, here we provide static recent imagery
  # -------------------------------------------------------------------------
  nasa_gibs = list(
    # Web Mercator (EPSG:3857)
    blue_marble = "https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/1.0.0/WMTSCapabilities.xml",
    # Geographic (EPSG:4326)
    blue_marble_geo = "https://gibs.earthdata.nasa.gov/wmts/epsg4326/best/1.0.0/WMTSCapabilities.xml",
    # Antarctic (EPSG:3031)
    antarctic = "https://gibs.earthdata.nasa.gov/wmts/epsg3031/best/1.0.0/WMTSCapabilities.xml",
    # Arctic (EPSG:3413)
    arctic = "https://gibs.earthdata.nasa.gov/wmts/epsg3413/best/1.0.0/WMTSCapabilities.xml"
  ),

  # -------------------------------------------------------------------------
  # Geoscience Australia
  # -------------------------------------------------------------------------
  ga = list(
    topo_base_map = "https://services.ga.gov.au/gis/rest/services/Topographic_Base_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    national_base_map = "https://services.ga.gov.au/gis/rest/services/NationalMap/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
    national_base_map_grey = "http://services.ga.gov.au/gis/rest/services/NationalBaseMap_GreyScale/MapServer/WMTS/1.0.0/WMTSCapabilities.xml"
  ),

  # -------------------------------------------------------------------------
  # Digital Earth Australia
  # -------------------------------------------------------------------------
  dea = list(
    # DEA provides WMS/WMTS via OWS endpoint
    # https://ows.dea.ga.gov.au/
    ows = "https://ows.dea.ga.gov.au/?service=WMTS&version=1.0.0&request=GetCapabilities"
  ),

  # -------------------------------------------------------------------------
  # Switzerland - Swisstopo
  # -------------------------------------------------------------------------
  swisstopo = list(
    # Web Mercator
    base_3857 = "https://wmts.geo.admin.ch/EPSG/3857/1.0.0/WMTSCapabilities.xml",
    # Swiss LV95
    base_2056 = "https://wmts.geo.admin.ch/EPSG/2056/1.0.0/WMTSCapabilities.xml",
    # Geographic WGS84
    base_4326 = "https://wmts.geo.admin.ch/EPSG/4326/1.0.0/WMTSCapabilities.xml"
  ),

  # -------------------------------------------------------------------------
  # Netherlands - PDOK
  # -------------------------------------------------------------------------
  nl_pdok = list(
    achtergrondkaart = "https://service.pdok.nl/brt/achtergrondkaart/wmts/v2_0?service=WMTS&request=GetCapabilities",
    luchtfoto = "https://service.pdok.nl/hwh/luchtfotorgb/wmts/v1_0?service=WMTS&request=GetCapabilities"
  ),

  # -------------------------------------------------------------------------
  # Austria - basemap.at
  # -------------------------------------------------------------------------
  austria = list(
    basemap = "https://maps.wien.gv.at/basemap/1.0.0/WMTSCapabilities.xml"
  )
)

# ============================================================================
# PRE-BUILT SIMPLE STRINGS (no capabilities parsing needed)
# ============================================================================
# These are ready-to-use GDAL WMTS strings that don't require parsing

wmts_simple <- list(
  # ESRI World Imagery - the classic

  esri_world_imagery = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Imagery/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Imagery",

  # ESRI basemaps
  esri_world_street_map = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Street_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Street_Map",
  esri_world_topo = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Topo_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Topo_Map",
  esri_world_terrain = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/World_Terrain_Base/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Terrain_Base",
  esri_natgeo = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/NatGeo_World_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=NatGeo_World_Map",
  esri_ocean = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/Ocean_Basemap/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Ocean_Basemap",
  esri_dark_gray = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/Canvas/World_Dark_Gray_Base/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Dark_Gray_Base",
  esri_light_gray = "WMTS:https://services.arcgisonline.com/arcgis/rest/services/Canvas/World_Light_Gray_Base/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=World_Light_Gray_Base",

  # USGS National Map
  usgs_topo = "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSTopo/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSTopo",
  usgs_imagery = "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryOnly/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSImageryOnly",
  usgs_imagery_topo = "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryTopo/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSImageryTopo",
  usgs_shaded_relief = "WMTS:https://basemap.nationalmap.gov/arcgis/rest/services/USGSShadedReliefOnly/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=USGSShadedReliefOnly",

  # Geoscience Australia
  ga_topo = "WMTS:https://services.ga.gov.au/gis/rest/services/Topographic_Base_Map/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=Topographic_Base_Map",
  ga_national_map = "WMTS:https://services.ga.gov.au/gis/rest/services/NationalMap/MapServer/WMTS/1.0.0/WMTSCapabilities.xml,layer=NationalMap",

  # NASA GIBS - selected stable layers
  # Blue Marble
  nasa_blue_marble = "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration",
  nasa_blue_marble_geo = "WMTS:https://gibs.earthdata.nasa.gov/wmts/epsg4326/best/1.0.0/WMTSCapabilities.xml,layer=BlueMarble_NextGeneration",

  # Swisstopo (Web Mercator)
  swisstopo_pixelkarte = "WMTS:https://wmts.geo.admin.ch/EPSG/3857/1.0.0/WMTSCapabilities.xml,layer=ch.swisstopo.pixelkarte-farbe",
  swisstopo_swissimage = "WMTS:https://wmts.geo.admin.ch/EPSG/3857/1.0.0/WMTSCapabilities.xml,layer=ch.swisstopo.swissimage",

  # Netherlands
  nl_achtergrondkaart = "WMTS:https://service.pdok.nl/brt/achtergrondkaart/wmts/v2_0?service=WMTS&request=GetCapabilities,layer=standaard"
)

# ============================================================================
# XYZ TILE SERVICES (as GDAL_WMS XML - for comparison/fallback)
# These are the TMS/XYZ style that also work with GDAL
# ============================================================================

xyz_templates <- list(
  # OpenStreetMap
  osm = list(
    url = "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
    attribution = "© OpenStreetMap contributors"
  ),

  # OpenTopoMap
  opentopomap = list(
    url = "https://tile.opentopomap.org/{z}/{x}/{y}.png",
    attribution = "© OpenTopoMap (CC-BY-SA)"
  ),

  # Stamen/Stadia (now requires API key for production)
  stadia_toner = list(
    url = "https://tiles.stadiamaps.com/tiles/stamen_toner/{z}/{x}/{y}.png",
    attribution = "© Stadia Maps, © Stamen Design"
  ),

  stadia_terrain = list(
    url = "https://tiles.stadiamaps.com/tiles/stamen_terrain/{z}/{x}/{y}.png",
    attribution = "© Stadia Maps, © Stamen Design"
  ),

  stadia_watercolor = list(
    url = "https://tiles.stadiamaps.com/tiles/stamen_watercolor/{z}/{x}/{y}.jpg",
    attribution = "© Stadia Maps, © Stamen Design"
  )
)

# ============================================================================
# OUTPUT: Package data structure
# ============================================================================

# The main catalog - simple strings ready for GDAL use
catalog <- wmts_simple

# Additional metadata for documentation
catalog_metadata <- list(
  version = "0.1.0",
  generated = Sys.time(),
  sources = names(wmts_endpoints),
  description = "WMTS connection strings for GDAL. Use with vrt:// for advanced operations."
)

# Save for package use
# usethis::use_data(catalog, catalog_metadata, internal = TRUE)

# Print summary
cat("WMTS Catalog Summary\n")
cat("====================\n")
cat(sprintf("Total entries: %d\n", length(catalog)))
cat(sprintf("\nProviders:\n"))
for (provider in unique(gsub("_.*", "", names(catalog)))) {
  n <- sum(grepl(sprintf("^%s_", provider), names(catalog)))
  cat(sprintf("  - %s: %d layers\n", provider, n))
}

cat("\n\nExample usage:\n")
cat("  dsn <- sds::wmts('esri_world_imagery')\n")
cat("  # Returns: WMTS:https://services.arcgisonline.com/...,layer=World_Imagery\n")
cat("\n")
cat("  # Use with vrt:// for overview/projection control:\n")
cat("  dsn <- paste0('vrt://', sds::wmts('esri_world_imagery'), '?ovr=15')\n")
