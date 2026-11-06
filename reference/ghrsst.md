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
#> [1] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/10/30/20261030090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [2] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/10/31/20261031090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [3] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/11/01/20261101090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [4] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/11/02/20261102090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [5] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/11/03/20261103090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
#> [6] "/vsicurl/https://data.source.coop/ausantarctic/ghrsst-mur-v2/2026/11/04/20261104090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1_analysed_sst.tif"
```
