#' Sea ice CDR (climate data record) url
#'
#' The first subdataset 'cdr_seaice_conc' is the one you want, but also included
#' are "cdr_seaice_conc_interp_spatial_flag", "cdr_seaice_conc_interp_temporal_flag",
#' "cdr_seaice_conc_qa_flag", "cdr_seaice_conc_stdev", "raw_bt_seaice_conc", "raw_nt_seaice_conc" and
#'                    "surface_type_mask"
#'
#' I've had mixed success setting subdataset and having these return with the correct orientation.
#' @param date date or or string YYYY-mm-dd
#' @param hemisphere north or south
#' @param vsi in GDAL url form
#'
#' @returns string with path to CDR sea ice netcdf file
#' @export
#'
#' @examples
#' seaice_cdr()
seaice_cdr <- function(date, hemisphere = c("south", "north"), vsi = TRUE) {
  if (missing(date)) {
    date <- Sys.Date() - 8L
  }
  hemisphere <- match.arg(hemisphere)
  hemi_code <- c(north = "psn25", south = "pss25")
  hemi_dir  <- c(north = "north", south = "south")

  date <- as.Date(date)
  if (date < as.Date("1978-10-25")) {
    warning('at time of writing CDR has no date earlier than 1978-10-25')
  }
  sensor <- dplyr::case_when(
    date <= as.Date("1987-07-09") ~ "n07",
    date <= as.Date("1991-12-02") ~ "F08",
    date <= as.Date("1995-09-30") ~ "F11",
    date <= as.Date("2007-12-31") ~ "F13",
    date <= as.Date("2024-12-31") ~ "F17",
    TRUE                          ~ "am2"
  )
base <- "https://noaadata.apps.nsidc.org/NOAA/G02202_V6/%s/daily/%s/sic_%s_%s_%s_v06r00.nc"
if (vsi) {
  base <- sprintf("/vsicurl/%s", base)
}
  sprintf(
    base,
    hemi_dir[hemisphere],
    format(date, "%Y"),
    hemi_code[hemisphere],
    format(date, "%Y%m%d"),
    sensor
  )
}

cdr_urls <- function(hemisphere = c("north", "south"),
                     end_date = Sys.Date()) {
  hemisphere <- match.arg(hemisphere, several.ok = TRUE)
  hemi_code <- c(north = "psn25", south = "pss25")
  hemi_dir  <- c(north = "north", south = "south")

  sensor_eras <- tibble::tribble(
    ~sensor, ~start,       ~end,
    "n07",   "1978-10-25", "1987-07-09",
    "F08",   "1987-07-10", "1991-12-02",
    "F11",   "1991-12-03", "1995-09-30",
    "F13",   "1995-10-01", "2007-12-31",
    "F17",   "2008-01-01", "2024-12-31",
    "am2",   "2025-01-01", NA_character_
  )
  sensor_eras$start <- as.Date(sensor_eras$start)
  sensor_eras$end   <- as.Date(ifelse(is.na(sensor_eras$end),
                                      as.character(end_date),
                                      sensor_eras$end))
  sensor_eras$end   <- pmin(sensor_eras$end, end_date)

  result <- vector("list", nrow(sensor_eras) * length(hemisphere))
  k <- 1L
  for (h in hemisphere) {
    for (i in seq_len(nrow(sensor_eras))) {
      dates <- seq(sensor_eras$start[i], sensor_eras$end[i], by = "day")
      result[[k]] <- data.frame(
        hemi   = h,
        date   = dates,
        sensor = sensor_eras$sensor[i],
        url    = sprintf(
          "https://noaadata.apps.nsidc.org/NOAA/G02202_V6/%s/daily/%s/sic_%s_%s_%s_v06r00.nc",
          hemi_dir[h],
          format(dates, "%Y"),
          hemi_code[h],
          format(dates, "%Y%m%d"),
          sensor_eras$sensor[i]
        ),
        stringsAsFactors = FALSE
      )
      k <- k + 1L
    }
  }
  do.call(rbind, result)
}
