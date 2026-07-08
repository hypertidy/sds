# R/registry.R
# The sds registry: a CSV of named spatial data sources, and its accessors.
#
# Design:
# - inst/extdata/sds-registry.csv is the source of truth (one row per source,
#   plain ASCII, diffable, editable in the GitHub web UI).
# - dsn(name) returns a ready-to-use GDAL DSN. There is no vsi/prefix toggle:
#   the registry knows the 'kind' of every source, so the correct dressing is
#   applied unconditionally, expressed in dsn-package verbs. To undress, use
#   dsn::unvsicurl() / dsn::unprefix(), or take the bare 'url' column from
#   dsn_list().
# - Multi-line payloads (GDAL_WMS XML, VRT text) live as files in
#   inst/sources/ and are referenced by filename in the 'url' column with
#   kind 'xml_file' or 'vrt_file'.
#
# Requires (Imports): dsn (>= the version with vsizip()).

.sds_env <- new.env(parent = emptyenv())

.registry_path <- function() {
  system.file("extdata", "sds-registry.csv", package = "sds", mustWork = TRUE)
}

#' @noRd
.registry <- function() {
  if (is.null(.sds_env$registry)) {
    reg <- utils::read.csv(.registry_path(), colClasses = "character",
                           strip.white = TRUE)
    #reg[] <- lapply(reg, function(col) trimws(gsub("\r|\xC2\xA0", "", col)))
    dup <- reg$name[duplicated(reg$name)]
    if (length(dup)) {
      stop(sprintf("sds registry has duplicated names: %s",
                   paste(unique(dup), collapse = ", ")), call. = FALSE)
    }
    .sds_env$registry <- reg
  }
  .sds_env$registry
}

#' @noRd
.payload <- function(file) {
  path <- system.file("sources", file, package = "sds", mustWork = TRUE)
  paste0(readLines(path, warn = FALSE), collapse = "\n")
}

## kind -> dressing, expressed in dsn verbs
#' @noRd
.dress <- function(url, kind) {
  switch(kind,
         cog        = ,
         vrt_url    = ,
         gpkg       = ,
         parquet    = dsn::vsicurl(url),
         zip_vector = dsn::vsizip(dsn::vsicurl(url)),
         wmts       = ,
         raw        = url,
         xml_file   = ,
         vrt_file   = .payload(url),
         stop(sprintf("unknown kind '%s' in sds registry", kind), call. = FALSE)
  )
}

#' Data source name for a named spatial data source
#'
#' Look up a source by name in the sds registry and return a GDAL-ready data
#' source name (DSN). The registry records the kind of every source, so the
#' returned string is fully dressed: '/vsicurl/' for online rasters and
#' Parquet, '/vsizip//vsicurl/' for zipped vector sources, complete 'WMTS:'
#' connection strings for tile services, and full XML or VRT text for
#' sources that are recipes rather than URLs.
#'
#' There is deliberately no prefix toggle. If you want the bare URL, take it
#' from the 'url' column of [dsn_list()], or unchain with [dsn::unvsicurl()].
#' To chain further, compose with dsn verbs or the 'vrt://' protocol, for
#' example 'paste0("vrt://", dsn("esri_world_imagery"), "?ovr=12")'.
#'
#' @param name character vector of registry names, see [dsn_list()]
#'
#' @return character vector of GDAL data source names, same length as 'name'
#' @export
#'
#' @examples
#' dsn("gebco25")
#' dsn(c("cop30", "nasa_antarctic_modis"))
#' dsn_list(theme = "bathymetry")$name
dsn <- function(name) {
  reg <- .registry()
  vapply(name, function(nm) {
    i <- match(nm, reg$name)
    if (is.na(i)) {
      hits <- grep(nm, reg$name, ignore.case = TRUE, value = TRUE)
      hint <- if (length(hits)) {
        sprintf(" Did you mean one of: %s?", paste(hits, collapse = ", "))
      } else {
        " See dsn_list() for the catalog."
      }
      stop(sprintf("sds: no source named '%s'.%s", nm, hint), call. = FALSE)
    }
    row <- reg[i, ]
    if (identical(row$status, "dead")) {
      stop(sprintf("sds: source '%s' is dead. %s", nm, row$notes),
           call. = FALSE)
    }
    if (identical(row$status, "deprecated")) {
      warning(sprintf("sds: source '%s' is deprecated. %s", nm, row$notes),
              call. = FALSE)
    }
    if (nzchar(row$needs_auth) && !nzchar(Sys.getenv(row$needs_auth))) {
      warning(sprintf("sds: source '%s' expects env var '%s' to be set",
                      nm, row$needs_auth), call. = FALSE)
    }
    .dress(row$url, row$kind)
  }, character(1), USE.NAMES = length(name) > 1L)
}

#' List and filter the sds registry
#'
#' Returns the registry as a data frame, optionally filtered. This is the
#' discovery surface: themes, providers, kinds, licenses, and liveness
#' status are all columns you can inspect.
#'
#' @param pattern optional pattern matched against 'name' (grep, case
#'   insensitive)
#' @param theme optional theme filter, e.g. "elevation", "bathymetry",
#'   "imagery", "basemap", "admin"
#' @param provider optional provider filter, e.g. "gebco", "usgs",
#'   "nasa_gibs", "thelist"
#' @param kind optional kind filter, e.g. "cog", "wmts", "parquet"
#'
#' @return data frame, one row per source
#' @export
#'
#' @examples
#' dsn_list(theme = "bathymetry")
#' dsn_list(provider = "nasa_gibs")
#' dsn_list("antarctic")
dsn_list <- function(pattern = NULL, theme = NULL, provider = NULL,
                     kind = NULL) {
  reg <- .registry()
  if (!is.null(pattern)) {
    reg <- reg[grepl(pattern, reg$name, ignore.case = TRUE), ]
  }
  if (!is.null(theme))    reg <- reg[reg$theme %in% theme, ]
  if (!is.null(provider)) reg <- reg[reg$provider %in% provider, ]
  if (!is.null(kind))     reg <- reg[reg$kind %in% kind, ]
  rownames(reg) <- NULL
  reg
}

#' @rdname dsn_list
#' @param name a single registry name
#' @export
dsn_info <- function(name) {
  reg <- .registry()
  i <- match(name[1L], reg$name)
  if (is.na(i)) stop(sprintf("sds: no source named '%s'", name), call. = FALSE)
  row <- reg[i, ]
  cat(sprintf("%s [%s / %s / %s]\n", row$name, row$kind, row$theme,
              row$provider))
  if (nzchar(row$crs))     cat(sprintf("  crs:     %s\n", row$crs))
  if (nzchar(row$license)) cat(sprintf("  license: %s\n", row$license))
  if (nzchar(row$status))  cat(sprintf("  status:  %s\n", row$status))
  if (nzchar(row$notes))   cat(sprintf("  %s\n", row$notes))
  invisible(row)
}

## ---------------------------------------------------------------------------
## Shim pattern for existing exports (these live in themed files, e.g.
## R/elevation.R). The vsi argument is retained for backwards compatibility
## only; new code should call dsn() and chain with dsn verbs.
##
## gebco25 <- function(vsi = TRUE) {
##   out <- dsn("gebco25")
##   if (!vsi) out <- dsn::unvsicurl(out)
##   out
## }
## gebco <- function(vsi = TRUE) gebco25(vsi = vsi)
## ---------------------------------------------------------------------------
