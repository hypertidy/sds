# the geoBoundaries countries

CGAZ() returns the DSN, a shapefile of geo boundaries, CGAZ_sql()
returns SQL suitable for use with GDAL, for the names or codes of
countries.

## Usage

``` r
CGAZ(old = FALSE)

CGAZ_sql(codes)
```

## Arguments

- old:

  logical, return the old slow zipped shapefile or the new Parquet copy

- codes:

  a list of iso3 country codes, or country names (this is a bit sketchy)

## Value

character string; `CGAZ()` returns a GDAL data source name and
`CGAZ_sql()` returns an SQL query string

## Examples

``` r
CGAZ_sql(c("Australia", "New Zealand"))
#> [1] "SELECT shapeGroup FROM geoBoundariesCGAZ_ADM0 WHERE shapeGroup IN ('AUS','NZL')"
CGAZ_sql(c("AUS", "NZL"))
#> [1] "SELECT shapeGroup FROM geoBoundariesCGAZ_ADM0 WHERE shapeGroup IN ('AUS','NZL')"
## do something like gdal_raster_data(gebco(), target_res = 1,
##                                        options = c("-crop_to_cutline",
##                                        "-cutline", CGAZ(),
##                                         "-csql", CGAZ_sql(c("Australia", "New Zealand")) ))
```
