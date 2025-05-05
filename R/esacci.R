
#' ESACCI chlorophyll-a in monthly
#'
#' @param time.resolution monthly only for now
#'
#' @return data frame with date,source
#' @export
#'
#' @examples
#' dsn <- esacci_chlor_a()
esacci_chlor_a <- function(time.resolution = "monthly") {
  template <- "vrt:///vsicurl/https://www.oceancolour.org/thredds/fileServer/cci/v6.0-release/geographic/monthly/chlor_a/%s/ESACCI-OC-L3S-CHLOR_A-MERGED-1M_MONTHLY_4km_GEO_PML_OCx-%s-fv6.0.nc?sd_name=chlor_a&a_srs=EPSG:4326&a_ullr=-180,90,180,-90"

  ##199709
  dates <- seq(as.Date("1997-09-15"), trunc(Sys.Date(), "months") - 15, by = "1 month")
  YEARMON <- format(dates, "%Y%m")
  YEAR <- format(dates, "%Y")
  tibble::tibble(date = as.POSIXct(dates), source = sprintf(template, YEAR, YEARMON))
}
