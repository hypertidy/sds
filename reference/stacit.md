# STAC Query URL Generator

Generate STAC API search URLs from an extent and date specification.
Provides a simple interface for constructing valid STAC queries without
manually assembling URL parameters.

## Usage

``` r
stacit(
  extent,
  date = "",
  collections = "sentinel-2-c1-l2a",
  provider = c("https://earth-search.aws.element84.com/v1/search",
    "https://planetarycomputer.microsoft.com/api/stac/v1/search"),
  gdal_stacit = FALSE,
  limit = 300
)
```

## Arguments

- extent:

  numeric vector (xmin, xmax, ymin, ymax) in longlat, or character MGRS
  100km grid code

- date:

  character, Date, or POSIXt specifying the temporal query. Length 1 for
  an implied interval or length 2 for an explicit range. Default `""`
  uses today's date.

- collections:

  character; STAC collection identifier(s) to search. Default is
  `"sentinel-2-c1-l2a"` (Sentinel-2 Cloud-Optimized GeoTIFFs).

- provider:

  character; base URL of the STAC API search endpoint. Default uses
  Element 84's Earth Search. Also supports Microsoft Planetary Computer.

- gdal_stacit:

  logical; if `TRUE`, return a GDAL STACIT driver DSN string instead of
  a URL. Default `FALSE`.

- limit:

  integer; maximum number of items to return per query. Default 300.

## Value

Character vector of STAC search URL(s). Returns multiple URLs when the
extent crosses the anti-meridian.

## Extent specification

The extent can be specified as either:

- A numeric vector of length 4 giving xmin, xmax, ymin, ymax in
  longitude/latitude (EPSG:4326)

- A character string giving a 100km MGRS grid square code (e.g. "43DFD")

Extents that cross the anti-meridian (i.e. where xmin \< -180 or xmax \>
180) are automatically split into two queries, one for each side of the
±180° boundary. This handles the case where a projected extent (e.g.
UTM) spans the anti-meridian but STAC APIs truncate bounding boxes at
-180/180.

## Date specification

The date parameter accepts flexible input formats that are expanded to
ISO 8601 datetime intervals:

- Year only: `"2024"` becomes
  `2024-01-01T00:00:00Z/2024-12-31T23:59:59Z`

- Year-month: `"2024-06"` expands to the full month interval

- Full date: `"2024-06-15"` expands to that single day

- Date range: `c("2024-01-01", "2024-01-31")` for explicit start/end

- Date or POSIXt objects are also accepted

## References

STAC API specification: <https://github.com/radiantearth/stac-api-spec>

GDAL STACIT driver:
<https://gdal.org/en/stable/drivers/raster/stacit.html>

## See also

[`mpc()`](https://hypertidy.github.io/sds/reference/mpc.md) for
Microsoft Planetary Computer catalog access;
[`sentinel2_wms()`](https://hypertidy.github.io/sds/reference/sentinel2_wms.md)
for Sentinel-2 WMS layer construction

## Examples

``` r
# Simple bounding box query for today
stacit(c(140, 145, -43, -40))
#> [1] "https://earth-search.aws.element84.com/v1/search?collections=sentinel-2-c1-l2a&bbox=140,-43,145,-40&datetime=2026-09-30T00:00:00Z/2026-09-30T23:59:59Z&limit=300"

# MGRS grid square for a specific month
stacit("43DFD", date = "2025-01")
#> [1] "https://earth-search.aws.element84.com/v1/search?collections=sentinel-2-c1-l2a&query=%7B%22grid:code%22:%7B%22eq%22:%22MGRS-43DFD%22%7D%7D&datetime=2025-01-01T00:00:00Z/2025-01-31T23:59:59Z&limit=300"

# Date range query
stacit(c(140, 145, -43, -40), date = c("2024-06-01", "2024-06-30"))
#> [1] "https://earth-search.aws.element84.com/v1/search?collections=sentinel-2-c1-l2a&bbox=140,-43,145,-40&datetime=2024-06-01T00:00:00Z/2024-06-30T23:59:59Z&limit=300"

# Anti-meridian crossing returns two queries
stacit(c(179, 181, -16, -15), date = "2024-03")
#> [1] "https://earth-search.aws.element84.com/v1/search?collections=sentinel-2-c1-l2a&bbox=179,-16,180,-15&datetime=2024-03-01T00:00:00Z/2024-03-31T23:59:59Z&limit=300"  
#> [2] "https://earth-search.aws.element84.com/v1/search?collections=sentinel-2-c1-l2a&bbox=-180,-16,-179,-15&datetime=2024-03-01T00:00:00Z/2024-03-31T23:59:59Z&limit=300"

# Use Planetary Computer instead of Earth Search
stacit(c(140, 145, -43, -40),
       provider = "https://planetarycomputer.microsoft.com/api/stac/v1/search")
#> [1] "https://planetarycomputer.microsoft.com/api/stac/v1/search?collections=sentinel-2-c1-l2a&bbox=140,-43,145,-40&datetime=2026-09-30T00:00:00Z/2026-09-30T23:59:59Z&limit=300"

# Query Landsat collection
stacit(c(140, 145, -43, -40), collections = "landsat-c2-l2", date = "2024")
#> [1] "https://earth-search.aws.element84.com/v1/search?collections=landsat-c2-l2&bbox=140,-43,145,-40&datetime=2024-01-01T00:00:00Z/2024-12-31T23:59:59Z&limit=300"
```
