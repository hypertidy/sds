# GHRSST files, GeoTIFFs on source.coop

GHRSST files, GeoTIFFs on source.coop

## Usage

``` r
ghrsst(vsi = TRUE)
```

## Arguments

- vsi:

  include the 'vsicurl' prefix (`TRUE` is default)

## Value

dataframe of source,date

## Examples

``` r
files <- ghrsst()
tail(files$source)
#> [1] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/09/24/20260924090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [2] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/09/25/20260925090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [3] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/09/26/20260926090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [4] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/09/27/20260927090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [5] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/09/28/20260928090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [6] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/09/29/20260929090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
```
