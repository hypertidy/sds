# USGS seamless DEM

USGS seamless DEM

## Usage

``` r
usgs_seamless(vsicurl = TRUE)
```

## Arguments

- vsicurl:

  if TRUE prefix /vsicurl

## Value

character string, a GDAL data source name for the USGS seamless DEM

## Examples

``` r

usgs_seamless()
#> [1] "/vsicurl/https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/1/TIFF/USGS_Seamless_DEM_1.vrt"
```
