
#' Mapterhorn PMTiles raster elevation
#'
#' Rendered calc VRT that unpacks planet.pmtiles from Mapterhorn, a large collection of
#' regional elevation sources encoded in Terrarium Terrain RGB '(R*256 + G + B/256) - 32768'
#'
#' @param ... unused
#'
#' @returns VRT text string, useable by GDAL >= 3.14 with muparser support
#' @export
#'
#' @examples
#' writeLines(mapterhorn_elevation())
mapterhorn_elevation <- function(...) {
  dsn("mapterhorn_elevation")
}

