# GADM administrative boundaries

GADM 4.1 whole-planet administrative areas as GeoParquet, hosted as an
sds release asset. The original single GeoPackage from
geodata.ucdavis.edu is available as `dsn("gadm_gpkg")`. GADM data is
free for academic and non-commercial use only, see gadm.org/license.

## Usage

``` r
gadm(vsi = TRUE)
```

## Arguments

- vsi:

  include the 'vsicurl' prefix (`TRUE` is default)

## Value

data source name for GADM 4.1 GeoParquet

## Examples

``` r
gadm()
#> [1] "/vsicurl/https://github.com/hypertidy/sds/releases/download/latest/gadm_410.parquet"
```
