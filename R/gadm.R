gadm <- function(vsi = TRUE) {
  bas <- "https://github.com/hypertidy/sds/releases/download/latest/gadm_410.parquet"
  if (!vsi) {
    return(bas)
  }
  sprintf("/vsicurl/%s", bas)
}
