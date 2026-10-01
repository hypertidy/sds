# REMA reference elevation model of Antarctica

This is a single description string for all of the 2m REMA. The VRT is
crafted with efficient overviews so is much more performant with the
warper API than other existing descriptions.

## Usage

``` r
rema()

rema_v2()
```

## Value

character string, GDAL-readable raster data source name

## Details

See [rema-ovr](https://github.com/mdsumner/rema-ovr) for examples.

## Examples

``` r
rema()
#> [1] "/vsicurl/https://raw.githubusercontent.com/mdsumner/rema-ovr/main/REMA-2m_dem_ovr.vrt"
```
