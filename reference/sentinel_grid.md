# Sentinel-2 MGRS tile grid

The Sentinel-2 (MGRS 100km) tiling grid, one row per tile with native
UTM extent and longitude/latitude extent, used by
[`stacit()`](https://hypertidy.github.io/sds/reference/stacit.md) to
resolve a 5-character MGRS square designator (e.g. "55GEP") to a query
extent.

## Usage

``` r
sentinel_grid
```

## Format

A data frame with 56686 rows and 15 columns:

- land:

  logical, tile intersects land

- xmin,xmax,ymin,ymax:

  numeric, tile extent in native UTM

- crs:

  character, native UTM crs e.g. "EPSG:32701"

- zone:

  character, UTM zone "01".."60"

- latband:

  character, MGRS latitude band letter

- lonband:

  character, MGRS 100km column/row pair

- antim_wrap:

  logical, tile crosses the anti-meridian in longlat

- hemisphere:

  character, "north" or "south"

- ll_xmin,ll_ymin,ll_xmax,ll_ymax:

  numeric, tile extent in longlat

## Source

Derived from the ESA Sentinel-2 tiling grid KML, see
data-raw/sentinel-grid.R
