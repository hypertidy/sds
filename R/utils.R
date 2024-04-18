.datehandler <- function(x) {
  ## date could be
  ## empty ""  - we get yesterday
  ## just a string interval
  # %Y, %Y-%m, %Y-%m-%d
  #
  ## a range of dates (assume fencepost snaps out midnight0, to midnight-1s)
  # c(Date0, Date1) either string or Date

  ## a range of date-times (no more fencepost snap)
  ## c(POSIXct0, POSIXct1)
  len <- length(x)
  stopifnot(len > 0)
  stopifnot(len < 3)

  zulu <- "%Y-%m-%dT%H:%M:%SZ"
  if (len == 2L) {
    if (inherits(x, "Date")) {
      ## assume second date is 23:59:59
      dt <- as.POSIXct(x , tz = "UTC")+ c(0, 24 * 3600 - 1)
    }
    if (inherits(x, "POSIXct")) {
      ## just format and out (after checking)
      dt <- x
    }
    if (is.character(x)) {
      if (all(nchar(x) == 10L)) return(Recall(as.Date(x)))
      if (!length(unique(nchar(x))) == 1L) stop("input character strings must have equal length and compatible formatting")
      dt <- as.POSIXct(x, tz = "UTC")
    }
  }

  if (len == 1L) {
    if (!nzchar(x)) return(Recall(rep(Sys.Date() - 1, 2L)))
    nc <- nchar(x)

    ## cases 4, 7, or more
    if (nc == 4L) {
      dt <- c(as.Date(sprintf("%s-01-01", x)), as.Date(sprintf("%s-12-31", x)))
      return(Recall(dt))
    }
    if (nc == 7L) {
      return(Recall(seq(as.POSIXct(sprintf("%s-01", x)), by = "1 month", length.out = 2L) + c(0, -1)))
    }
    if (nc == 10L) {
      dt <- seq(as.POSIXct(x, tz = "UTC"), by = "1 day", length.out = 2L) + c(0, -1)
    }
    ## all other cases are at the mercy of BDR via as.POSIXct
    return(Recall(rep(x, 2L)))
  }

  dtd <- diff(dt)
  if (dtd < 0) stop("date range input must be in increasing order")
  paste0(format(dt, zulu), collapse = "/")
}
