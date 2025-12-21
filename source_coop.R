# R/source_coop.R
# Source Cooperative dataset catalog
# Cloud-native geospatial data (COG, GeoParquet, PMTiles, FlatGeobuf)
# No dependencies - just returns URIs

#' Source Cooperative Dataset Catalog
#'
#' Returns URIs for datasets hosted on Source Cooperative (source.coop).
#' These are cloud-native formats accessible via GDAL, DuckDB, or direct HTTP.
#'
#' @param name Character. Dataset name. Use `source_coop_list()` for options.
#' @param format Character. Preferred format: "parquet", "cog", "pmtiles", "fgb".
#'   If NULL (default
#'), returns the primary/recommended format.
#' @param protocol Character. "s3" (default) or "https".
#'
#' @return Character URI for the dataset.
#'
#' @details
#' Source Cooperative hosts open geospatial data in cloud-native formats.
#' Data can be accessed without authentication using:
#' - S3: `s3://us-west-2.opendata.source.coop/...` (with `--no-sign-request`)
#' - HTTP: `https://data.source.coop/...`
#'
#' These URIs work directly with:
#' - GDAL/terra/sf: COGs, GeoParquet, FlatGeobuf
#' - DuckDB: GeoParquet (with httpfs/spatial extensions)
#' - Web maps: PMTiles
#'
#' @examples
#' \dontrun
#' {
#' # Google-Microsoft-OSM Open Buildings (2.7B footprints!)
#' uri <- source_coop("open_buildings")
#'
#' # Read with DuckDB
#' library(DBI)
#' con <- dbConnect(duckdb::duckdb())
#' dbExecute(con, "INSTALL spatial; LOAD spatial;")
#' dbExecute(con, "INSTALL httpfs; LOAD httpfs;")
#' dbGetQuery(con, sprintf("SELECT count(*) FROM '%s'", uri))
#'
#' # US National Wetlands Inventory
#' nwi <- source_coop("nwi_wetlands", protocol = "https")
#'
#' # Overture Maps (Fused partitioned)
#' overture <- source_coop("overture_buildings")
#' }
#'
#' @export
source_coop <- function(name, format = NULL, protocol = c("s3", "https")) {
  protocol <- match.arg(protocol)
  catalog <- source_coop_catalog()

  if (!name %in% names(catalog)) {
    # Try partial match
    matches <- grep(name, names(catalog), ignore.case = TRUE, value = TRUE)
    if (length(matches) == 0) {
      stop(sprintf("Unknown dataset: '%s'. Use source_coop_list() to see options.", name))
    }
    if (length(matches) > 1 && !name %in% matches) {
      message(sprintf("Multiple matches: %s. Using first.", paste(matches, collapse = ", ")))
    }
    name <- matches[1]
  }

  entry <- catalog[[name]]

  # Select format
  if (is.null(format)) {
    # Use primary format
    uri_path <- entry$primary
  } else {
    format <- tolower(format)
    if (!format %in% names(entry$formats)) {
      available <- paste(names(entry$formats), collapse = ", ")
      stop(sprintf("Format '%s' not available. Options: %s", format, available))
    }
    uri_path <- entry$formats[[format]]
  }

  # Build URI
  if (protocol == "s3") {
    paste0("s3://us-west-2.opendata.source.coop/", uri_path)
  } else {
    paste0("https://data.source.coop/", uri_path)
  }
}


#' List Source Cooperative Datasets
#'
#' @param pattern Optional pattern to filter dataset names.
#' @param details Logical. If TRUE, return data frame with metadata.
#'
#' @return Character vector of dataset names, or data frame if details=TRUE.
#'
#' @export
source_coop_list <- function(pattern = NULL, details = FALSE) {
  catalog <- source_coop_catalog()

  if (!is.null(pattern)) {
    catalog <- catalog[grep(pattern, names(catalog), ignore.case = TRUE)]
  }

  if (details) {
    data.frame(
      name = names(catalog),
      description = vapply(catalog, function(x) x$description, character(1)),
      formats = vapply(catalog, function(x) paste(names(x$formats), collapse = ", "), character(1)),
      provider = vapply(catalog, function(x) x$provider, character(1)),
      stringsAsFactors = FALSE
    )
  } else {
    names(catalog)
  }
}


#' Source Cooperative Catalog Data
#'
#' @return Named list of dataset entries.
#' @keywords internal
source_coop_catalog <- function() {
  list(

    # =========================================================================
    # Building Footprints
    # =========================================================================

    open_buildings = list(
      description = "Google-Microsoft-OSM Open Buildings combined (2.7B footprints)",
      provider = "vida",
      primary = "vida/google-microsoft-osm-open-buildings/geoparquet/",
      formats = list(
        parquet = "vida/google-microsoft-osm-open-buildings/geoparquet/",
        pmtiles = "vida/google-microsoft-osm-open-buildings/pmtiles/",
        fgb = "vida/google-microsoft-osm-open-buildings/flatgeobuf/"
      )
    ),

    google_open_buildings = list(
      description = "Google Open Buildings v3 (admin1 partitioned)",
      provider = "cholmes",
      primary = "cholmes/google-open-buildings/geoparquet-admin1/",
      formats = list(
        parquet = "cholmes/google-open-buildings/geoparquet-admin1/"
      )
    ),

    overture_buildings = list(
      description = "Overture Maps buildings (Fused geo-partitioned)",
      provider = "fused",
      primary = "fused/overture/buildings_geoparquet/",
      formats = list(
        parquet = "fused/overture/buildings_geoparquet/"
      )
    ),

    overture_places = list(
      description = "Overture Maps places/POIs (Fused geo-partitioned)",
      provider = "fused",
      primary = "fused/overture/places_geoparquet/",
      formats = list(
        parquet = "fused/overture/places_geoparquet/"
      )
    ),

    overture_transportation = list(
      description = "Overture Maps transportation (Fused geo-partitioned)",
      provider = "fused",
      primary = "fused/overture/transportation_geoparquet/",
      formats = list(
        parquet = "fused/overture/transportation_geoparquet/"
      )
    ),

    # =========================================================================
    # Environmental / Land Cover
    # =========================================================================

    nwi_wetlands = list(
      description = "US National Wetlands Inventory",
      provider = "giswqs",
      primary = "giswqs/nwi/wetlands/",
      formats = list(
        parquet = "giswqs/nwi/wetlands/"
      )
    ),

    land_carbon_biodiversity = list(
      description = "Deforestation, carbon emissions, biodiversity indicators",
      provider = "vizzuality",
      primary = "vizzuality/lg-land-carbon-data/",
      formats = list(
        cog = "vizzuality/lg-land-carbon-data/"
      )
    ),

    # =========================================================================
    # Agriculture / Crop Data
    # =========================================================================

    hls_crop_classification = list(
      description = "HLS imagery chips for crop type ML (CONUS 2022)",
      provider = "clarkcga",
      primary = "clarkcga/multi-temporal-crop-classification/",
      formats = list(
        cog = "clarkcga/multi-temporal-crop-classification/"
      )
    ),

    fields_of_the_world = list(
      description = "Agricultural field boundary benchmark dataset",
      provider = "kerner-lab",
      primary = "kerner-lab/fields-of-the-world/",
      formats = list(
        parquet = "kerner-lab/fields-of-the-world/"
      )
    ),

    # =========================================================================
    # Satellite Imagery
    # =========================================================================

    rapidai4eo = list(
      description = "Dense time series satellite imagery corpus (Planet)",
      provider = "planet",
      primary = "planet/rapidai4eo/",
      formats = list(
        cog = "planet/rapidai4eo/"
      )
    ),

    alphaearth_embeddings = list(
      description = "Annual satellite embedding dataset 2018-2024",
      provider = "tge-labs",
      primary = "tge-labs/aef/",
      formats = list(
        cog = "tge-labs/aef/"
      )
    ),

    # =========================================================================
    # Administrative / Reference
    # =========================================================================

    epc_england_wales = list(
      description = "Energy Performance Certificates - England & Wales",
      provider = "addresscloud",
      primary = "addresscloud/epc/geoparquet/",
      formats = list(
        parquet = "addresscloud/epc/geoparquet/"
      )
    ),

    # =========================================================================
    # Ocean / Marine (relevant for Antarctic work!)
    # =========================================================================

    auspatious_sst = list(
      description = "High-resolution sea surface temperature (Australia)",
      provider = "auspatious",
      primary = "auspatious/",
      formats = list(
        cog = "auspatious/"
      )
    )
  )
}


#' Show Source Cooperative Catalog Info
#'
#' @export
source_coop_info <- function() {
  catalog <- source_coop_catalog()

  cat("Source Cooperative Dataset Catalog\n")
  cat("==================================\n\n")
  cat(sprintf("Total datasets: %d\n\n", length(catalog)))

  cat("Access patterns:\n")
  cat("  S3:    s3://us-west-2.opendata.source.coop/<path>\n")
  cat("  HTTPS: https://data.source.coop/<path>\n\n")

  cat("Datasets:\n")
  for (nm in names(catalog)) {
    entry <- catalog[[nm]]
    fmts <- paste(names(entry$formats), collapse = "/")
    cat(sprintf("  %s [%s]\n", nm, fmts))
    cat(sprintf("    %s\n", entry$description))
  }

  cat("\nUsage:\n")
  cat("  uri <- source_coop('open_buildings')\n")
  cat("  # DuckDB: SELECT * FROM '<uri>/*.parquet' LIMIT 10\n")
  cat("  # GDAL:   terra::vect(uri)\n")

 invisible(catalog)
}


#' Build DuckDB query for Source Cooperative GeoParquet
#'
#' Helper to construct a DuckDB-compatible query string.
#'
#' @param name Dataset name
#' @param query SQL query fragment (e.g., "WHERE area > 1000 LIMIT 100")
#' @param country ISO country code for partitioned datasets
#'
#' @return Character string with full DuckDB query
#'
#' @examples
#' \dontrun
#' {
#' # Query buildings in South Sudan
#' q <- source_coop_query("google_open_buildings",
#'                         country = "SSD",
#'                         query = "LIMIT 1000")
#' # Returns: SELECT * FROM 's3://...country=SSD/*.parquet' LIMIT 1000
#' }
#'
#' @export
source_coop_query <- function(name, query = NULL, country = NULL) {
  uri <- source_coop(name, protocol = "s3")

  # Handle country partition
  if (!is.null(country)) {
    uri <- paste0(uri, "country=", toupper(country), "/")
  }

  # Add wildcard for parquet
  if (grepl("/$", uri)) {
    uri <- paste0(uri, "*.parquet")
  }

  sql <- sprintf("SELECT * FROM '%s'", uri)
  if (!is.null(query)) {
    sql <- paste(sql, query)
  }

  sql
}
