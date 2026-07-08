# Additions to hypertidy/dsn R/prefix.R
# Chainable VSI prefixes to complete the vocabulary that sds composes with.
# These join the existing @name prefix roxygen group.
#
# The composition model: prefixes chain exactly as GDAL VSI chains, e.g.
#   vsizip(vsicurl("https://host/data.zip/layer.shp"))
#   -> "/vsizip//vsicurl/https://host/data.zip/layer.shp"

#' @name prefix
#' @export
#' @examples
#' vsizip(vsicurl("https://host/data.zip/inner/layer.shp"))
vsizip <- function(x) {
  sprintf("/vsizip/%s", x)
}

#' @name prefix
#' @export
#' @examples
#' vsis3("bucket/prefix/key.tif")
vsis3 <- function(x) {
  sprintf("/vsis3/%s", x)
}

#' @name prefix
#' @export
vsitar <- function(x) {
  sprintf("/vsitar/%s", x)
}

#' @name prefix
#' @export
vsigzip <- function(x) {
  sprintf("/vsigzip/%s", x)
}
