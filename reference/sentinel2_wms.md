# Sentinel 2 WMS

To use this you must have your own "INSTANCE_ID", set this in env var
"SENTINELHUB_INSTANCE_ID".

## Usage

``` r
sentinel2_wms(
  layer = c("TRUE-COLOR-S2L2A", "NDVI", "FALSE-COLOR", "FALSE-COLOR-URBAN",
    "AGRICULTURE", "BATHYMETRIC", "GEOLOGY", "MOISTURE-INDEX", "SWIR", "NATURAL-COLOR"),
  datetime = NA
)
```

## Arguments

- layer:

  see layer options in the argument, default is "TRUE-COLOR-S2L2A"

- datetime:

  a valid datetime or NA for "latest"

## Value

a string to a WMS

## Examples

``` r
sentinel2_wms()
#> [1] "WMS:https://services.sentinel-hub.com/ogc/wms/?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetTile&LAYERS=TRUE-COLOR-S2L2A&SRS=EPSG:3857&BBOX=-20037508.342789,-20037508.342789,20037508.342789,20037508.342789"
```
