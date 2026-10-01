# IBCOS source dsn

A data source name to the IBCSO elevation 'COG' GeoTIFF.

## Usage

``` r
ibcso(vsi = TRUE, chart = FALSE)
```

## Arguments

- vsi:

  include the 'vsicurl' prefix (`TRUE` is default)

- chart:

  the image or the data? set to TRUE for image (it's a PDF)

## Value

character string, URL to online raster

## Details

Currently at v2.

## Examples

``` r
ibcso()
#> [1] "/vsicurl/https://github.com/mdsumner/ibcso-cog/raw/main/IBCSO_v2_ice-surface_cog.tif"
```
