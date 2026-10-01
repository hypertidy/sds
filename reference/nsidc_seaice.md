# Data sources for NOAA NSIDC GeoTIFF images for sea ice concentration and extent.

Data is colour-palette GeoTIFF in polar stereographic raster format.

## Usage

``` r
nsidc_seaice(
  date,
  hemisphere = c("south", "north"),
  temporal = c("daily", "monthly"),
  varname = c("concentration", "extent"),
  vsi = TRUE
)
```

## Arguments

- date:

  date in POSIXct or Date format, see Details

- hemisphere:

  hemisphere of data source, north or south

- temporal:

  temporal resolution of data source, daily or monthly

- varname:

  variable name to obtain, concentration or extent (note this is a
  colour image)

- vsi:

  prepend DSN with "/vsicurl/" or not

## Value

character string, GDAL readable DSN to a colour palette GeoTIFF (see
args 'vsi' and others for options)

## Details

The availability of the date is not checked currently, the minimum date
is 1978-10-26. Please note that these data were only every two days from
date, until a later time (FIXME get these details).

## Examples

``` r
nsidc_seaice("2023-06-27")
#> [1] "/vsicurl/https://noaadata.apps.nsidc.org/NOAA/G02135/south/daily/geotiff/2023/06_Jun/S_20230627_concentration_v4.0.tif"
```
