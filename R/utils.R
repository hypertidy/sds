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
  if(!len > 0) stop("date input is of length 0")
  if(!len < 3) stop("date input should be 1 or 2 values, not 3 or more")
  if (anyNA(x)) stop("missing value/s in date input")
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


## input x is xmin,xmax,ymin,ymax, output is bbox xmin,ymin,xmax,ymax (and possibly repeated 2x to split on antimeridia)
.extenthandler <- function(x) {
  if (is.character(x)) {
    ## assume it's a GZD identifier MGRS-{GZD}{100km square}
    return(sprintf('query={"grid:code":{"eq":"MGRS-%s"}}', x))
  }
  if (!is.numeric(x) && length(x) ==4L) stop("'extent' in stacit() must be valid c(xmin, xmax, ymin, ymax) longitude,latitude values")
  if (diff(x[1:2]) <= 0) stop("extent must be a valid c(xmin,xmax, ymin,ymax) vector (values <-180 and > 180 are allowed for xmin,xmax for across anti-meridian queries")
  if (diff(x[3:4]) <= 0) stop("extent must be a valid c(xmin,xmax,ymin,ymax) vector, with latitude values between -90,90")
  if ((x[3] < -90)  || (x[4] > 90)) warning("latitude ymin,ymax values outside of -90,90 range")
  if (x[2L] > 180) {
    bb <- c(paste0(c(x[1L], x[3L], 180, x[4L]), collapse = ","),
            paste0(c(-180, x[3], x[2] - 360, x[4]), collapse = ","))
  } else if (x[1] < -180) {
    bb <- c(paste0(c(-180, x[3L], x[2L], x[4L]), collapse = ","),
            paste0(c(x[1L] + 360, x[3], 180, x[4L]), collapse = ","))
  } else {
    bb <- paste0(x[c(1L, 3L, 2L, 4L)], collapse = ",")
  }

  sprintf("bbox=%s", bb)
}
