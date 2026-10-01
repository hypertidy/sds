# Microsoft Planetary Computer

Function `mpc()` will return a full data source name for a
Spatio-Temporal Asset Catalog ('STAC').

## Usage

``` r
mpc(
  collection = "sentinel-2-l2a",
  bbox = "146.5,-43.2,147.5,-42.2",
  datetime = Sys.Date() + c(-5, 1),
  asset = "",
  stacit = TRUE
)
```

## Arguments

- collection:

  name of the collection e.g. "sentinel-2-l2a", "naip", or
  ""landsat-c2-l2"

- bbox:

  a string in the form 'xmin,ymin,xmax,ymax' where x,y are longitude and
  latitude values (OR a numeric extent xmin,xmax,ymin,ymax)

- datetime:

  a datetime of 1 or 2 values to give a range in time, if only one is
  given it is treated as an open interval to the present

- asset:

  name of the asset of interest, e.g. for "sentinel-2-l2a" there is
  "visual", "AOT", "B04" etc.

- stacit:

  logical, treat this as a 'GDAL STACIT' source, or just a generic MPC
  query, 'TRUE' by default

## Value

a string, a data source name for 'GDAL'

## Details

Each argument has a default, use them to set the collection, datetime
range, bounding box, and asset.

If no asset is specfied the description is a complex source composed of
multiple subdatasets ('GDAL' terminology). In a 'STAC' context "asset"
and "subdataset" are synonomous for 'GDAL'.

## Examples

``` r
mpc()
#> [1] "STACIT:\"https://planetarycomputer.microsoft.com/api/stac/v1/search?collections=sentinel-2-l2a&bbox=146.5,-43.2,147.5,-42.2&datetime=2026-09-26T00:00:00Z/2026-10-02T00:00:00Z\""

## we can be more general than GDAL, and say do a query to get Parquet for MS Buildings

mpc(collection = "ms-buildings", stacit = FALSE, bbox = "140,-45,145,-30",
                                 datetime = as.Date("2000-01-01"))
#> [1] "https://planetarycomputer.microsoft.com/api/stac/v1/search?collections=ms-buildings&bbox=140,-45,145,-30&datetime=2000-01-01T00:00:00Z%2F.."
## read that url with jsonlite and investigate $features$assets$data$href
## but it's all abfs:// azure special links
```
