generic_supported <- function(x, type) {
  out <- x[[type]]
  if (is.null(out))
    stop(sprintf("'type=%s' is not supported, should be one of '%s' or 'all'",
                 type, paste(collapse = ", ", names(x))))
  out
}
aadc_geoserver <- function (type = c("WFS"))
{
  aadc <- c(WFS = "WFS:https://data.aad.gov.au/geoserver/ows?service=wfs&version=2.0.0&request=GetCapabilities",
            WMS = "WMS:https://data.aad.gov.au/geoserver/ows?service=WMS&version=1.3.0&request=GetCapabilities",
            WCS = "WCS:https://data.aad.gov.au/geoserver/ows?service=WCS&acceptversions=2.0.1&request=GetCapabilities")

  out <- generic_supported(aadc, type)
  out
}

dea_wmts <- function() {
  dea_geoserver("WMTS")
}
dea_geoserver <- function(type = c("WFS")) {
  dea <- c(WFS = "WFS:http://geoserver.dea.ga.gov.au/geoserver/wfs?REQUEST=GetCapabilities",
           WMTS = "WMTS:https://ows.dea.ga.gov.au/?service=WMTS&request=GetCapabilities")
           #WMTS = "WMTS:https://geoserver.dea.ga.gov.au/geoserver/gwc/service/wmts?REQUEST=GetCapabilities")
  out <- generic_supported(dea, type)
  out
}
