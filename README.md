
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sds

<!-- badges: start -->

[![R-CMD-check](https://github.com/hypertidy/spatial.datasources/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/hypertidy/spatial.datasources/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of sds is to provide spatial data sources!!

## Installation

You can install the development version of sds from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hypertidy/sds")
```

## Example

This shows some of the variety of the sources available.

``` r
library(sds)

gebco() ## a global seamless topography (bathymetry and elevation)
#> [1] "/vsicurl/https://gebco2023.s3.valeria.science/gebco_2023_land_cog.tif"

CGAZ()  ## a global nations boundaries dataset
#> [1] "/vsizip//vsicurl/https://github.com/wmgeolab/geoBoundaries/raw/main/releaseData/CGAZ/geoBoundariesCGAZ_ADM0.zip"

CGAZ_sql(c("New Zealand", "Australia")) ## a SQL query for the CGAZ polygons
#> [1] "SELECT shapeGroup FROM geoBoundariesCGAZ_ADM0 WHERE shapeGroup IN ('NZL','AUS')"

cop30()  ## a global 30m elevation data set 
#> [1] "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP30/COP30_hh.vrt"


mpc()  ## return STAC collections for use with GDAL
#> [1] "STACIT:\"https://planetarycomputer.microsoft.com/api/stac/v1/search?collections=sentinel-2-l2a&bbox=146.5,-43.2,147.5,-42.2&datetime=2023-11-06T00:00:00Z/2023-11-12T00:00:00Z\""

mpc( datetime = as.Date(c("2019-06-01", "2019-08-01")), 
    bbox = c(-148.56, -147.44, 60.80, 61.18), asset = "visual")
#> [1] "STACIT:\"https://planetarycomputer.microsoft.com/api/stac/v1/search?collections=sentinel-2-l2a&bbox=-148.56,60.8,-147.44,61.18&datetime=2019-06-01T00:00:00Z/2019-08-01T00:00:00Z\":asset=visual"

## or return just the string a for jsonlite read
js <- jsonlite::fromJSON(mpc(stacit  = F))
## do it how you like
js$features$assets$visual$href
#> [1] "https://sentinel2l2a01.blob.core.windows.net/sentinel2-l2/55/G/EP/2023/11/10/S2A_MSIL2A_20231110T000221_N0509_R030_T55GEP_20231110T032257.SAFE/GRANULE/L2A_T55GEP_A043785_20231110T000221/IMG_DATA/R10m/T55GEP_20231110T000221_TCI_10m.tif"
#> [2] "https://sentinel2l2a01.blob.core.windows.net/sentinel2-l2/55/G/EN/2023/11/10/S2A_MSIL2A_20231110T000221_N0509_R030_T55GEN_20231110T032256.SAFE/GRANULE/L2A_T55GEN_A043785_20231110T000221/IMG_DATA/R10m/T55GEN_20231110T000221_TCI_10m.tif"
#> [3] "https://sentinel2l2a01.blob.core.windows.net/sentinel2-l2/55/G/DP/2023/11/10/S2A_MSIL2A_20231110T000221_N0509_R030_T55GDP_20231110T032258.SAFE/GRANULE/L2A_T55GDP_A043785_20231110T000221/IMG_DATA/R10m/T55GDP_20231110T000221_TCI_10m.tif"
#> [4] "https://sentinel2l2a01.blob.core.windows.net/sentinel2-l2/55/G/DN/2023/11/10/S2A_MSIL2A_20231110T000221_N0509_R030_T55GDN_20231110T032256.SAFE/GRANULE/L2A_T55GDN_A043785_20231110T000221/IMG_DATA/R10m/T55GDN_20231110T000221_TCI_10m.tif"
#> [5] "https://sentinel2l2a01.blob.core.windows.net/sentinel2-l2/55/G/DP/2023/11/08/S2B_MSIL2A_20231108T001109_N0509_R073_T55GDP_20231108T032243.SAFE/GRANULE/L2A_T55GDP_A034848_20231108T001644/IMG_DATA/R10m/T55GDP_20231108T001109_TCI_10m.tif"
#> [6] "https://sentinel2l2a01.blob.core.windows.net/sentinel2-l2/55/G/DN/2023/11/08/S2B_MSIL2A_20231108T001109_N0509_R073_T55GDN_20231108T032239.SAFE/GRANULE/L2A_T55GDN_A034848_20231108T001644/IMG_DATA/R10m/T55GDN_20231108T001109_TCI_10m.tif"
```

There are image tile servers:

``` r
wms_arcgis_mapserver_ESRI.WorldImagery_tms()
#> [1] "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/${z}/${y}/${x}</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>17</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><MaxConnections>10</MaxConnections><Cache /></GDAL_WMS>"
wms_openstreetmap_tms()
#> [1] "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>https://tile.openstreetmap.org/${z}/${x}/${y}.png</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>18</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:3857</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><!--<UserAgent>Please add a specific user agent text, to avoid the default one being used, and potentially blocked by OSM servers in case a too big usage of it would be seen</UserAgent>--><Cache /></GDAL_WMS>"

## not shown else will reveal my INSTANCE_ID
wms <- sentinel2_wms()
```

And a very specific sea ice source:

``` r
nsidc_seaice(hemisphere = "south")
#> [1] "/vsicurl/https://noaadata.apps.nsidc.org/NOAA/G02135/south/daily/geotiff/2023/11_Nov/S_20231104_concentration_v3.0.tif"
nsidc_seaice(hemisphere = "north")
#> [1] "/vsicurl/https://noaadata.apps.nsidc.org/NOAA/G02135/north/daily/geotiff/2023/11_Nov/N_20231104_concentration_v3.0.tif"
```

## Code of Conduct

Please note that the sds project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
